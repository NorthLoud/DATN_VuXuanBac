package com.example.loudhotel.service.impl;

import com.example.loudhotel.dto.request.BillRequest;
import com.example.loudhotel.dto.response.BillResponse;
import com.example.loudhotel.entity.*;
import com.example.loudhotel.exception.BadRequestException;
import com.example.loudhotel.exception.ResourceNotFoundException;
import com.example.loudhotel.repository.*;
import com.example.loudhotel.service.BillService;
import com.example.loudhotel.service.RoomAssignmentService;
import com.example.loudhotel.utils.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

@Service
@RequiredArgsConstructor
public class BillServiceImpl implements BillService {

    private final BillRepository billRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;
    private final HotelRepository hotelRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final RoomAssignmentService roomAssignmentService;

    private BillResponse toResponse(Bill bill) {

        var assignments = roomAssignmentService.getByBill(bill);

        List<BillResponse.RoomItem> rooms = assignments.stream()
                .map(a -> BillResponse.RoomItem.builder()
                        .roomId(a.getRoom().getRoomId())
                        .roomNumber(a.getRoom().getRoomNumber())
                        .roomType(a.getBillDetail().getRoomType().getTypeName())
                        .capacity(a.getBillDetail().getRoomType().getCapacity())
                        .nights(a.getBillDetail().getNights())
                        .build()
                ).toList();

        return BillResponse.builder()
                .billId(bill.getBillId())
                .billCode(bill.getBillCode())

                .userId(bill.getUser().getUserId())
                .userName(bill.getUser().getUsername())

                .hotelId(bill.getHotel().getHotelId())
                .hotelName(bill.getHotel().getHotelName())
                .hotelAddress(bill.getHotel().getAddress())
                .managerEmail(bill.getHotel().getManager().getEmail())

                .orderName(bill.getOrderName())
                .orderEmail(bill.getOrderEmail())
                .orderPhone(bill.getOrderPhone())

                .checkInDate(bill.getCheckInDate())
                .checkOutDate(bill.getCheckOutDate())

                .totalCost(bill.getTotalCost())

                .billStatus(bill.getBillStatus())
                .paymentMethod(bill.getPaymentMethod())
                .cancelReason(bill.getCancelReason())
                .idCardCode(bill.getIdCardCode())

                .actualCheckInTime(bill.getActualCheckInTime())
                .actualCheckOutTime(bill.getActualCheckOutTime())

                .createdAt(bill.getCreatedAt())
                .updatedAt(bill.getUpdatedAt())

                .rooms(rooms)
                .build();
    }

    @Override
    public List<BillResponse> getAll() {
        return billRepository.findAll()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @Override
    public List<BillResponse> getBillsOfManager(Long managerId) {

        return billRepository
                .findByHotel_Manager_UserId(managerId)
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @Override
    public BillResponse create(Long userId, BillRequest request) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User không tồn tại"));

        Hotel hotel = hotelRepository.findById(request.getHotelId())
                .orElseThrow(() -> new ResourceNotFoundException("Hotel không tồn tại"));

        long nights = ChronoUnit.DAYS.between(
                request.getCheckInDate(),
                request.getCheckOutDate()
        );

        if (nights <= 0) {
            throw new BadRequestException("Check-out phải sau check-in");
        }

        List<BillDetail> details = new ArrayList<>();
        double totalCost = 0;

        for (BillRequest.RoomSelection r : request.getRooms()) {

            RoomType roomType = roomTypeRepository.findById(r.getTypeId())
                    .orElseThrow(() -> new RuntimeException("Room type not found"));

            // check đủ phòng
            int totalRooms = roomRepository.countByRoomType_TypeId(roomType.getTypeId());

            int booked = billRepository.countBookedRooms(
                    roomType.getTypeId(),
                    request.getCheckInDate(),
                    request.getCheckOutDate()
            );

            int available = totalRooms - booked;

            if (available < r.getQuantity()) {
                throw new BadRequestException("Không đủ phòng trống");
            }

            double price = roomType.getPrice();

            BillDetail bd = BillDetail.builder()
                    .roomType(roomType)
                    .quantity(r.getQuantity())   // 🔥 QUAN TRỌNG
                    .nights((int) nights)
                    .guestCount(r.getGuestCount())
                    .build();

            details.add(bd);

            totalCost += price * r.getQuantity() * nights;
        }

        Bill bill = Bill.builder()
                .user(user)
                .hotel(hotel)
                .billCode(generateBillCode())
                .orderName(request.getOrderName())
                .orderEmail(request.getOrderEmail())
                .orderPhone(request.getOrderPhone())
                .checkInDate(request.getCheckInDate())
                .checkOutDate(request.getCheckOutDate())
                .totalCost(totalCost)
                .idCardCode(request.getIdCardCode())
                .billStatus(Bill.BillStatus.PENDING)
                .paymentMethod(Bill.PaymentMethod.VNPAY)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .vnpTxnRef(UUID.randomUUID().toString().replace("-", ""))
                .build();

        for (BillDetail bd : details) {
            bd.setBill(bill);
        }

        bill.setBillDetails(details);

        billRepository.save(bill);

        return toResponse(bill);
    }

    private void checkManagerPermission(Bill bill){

        Long currentUserId =
                SecurityUtil.getCurrentUserId();

        Long managerId =
                bill.getHotel().getManager().getUserId();

        if(!managerId.equals(currentUserId)){

            throw new BadRequestException(
                    "Không có quyền thao tác bill này"
            );
        }
    }

    @Override
    public BillResponse cancel(Long billId) {

        Bill bill = getBill(billId);

        Long currentUserId = SecurityUtil.getCurrentUserId();

        boolean isManager =
                bill.getHotel().getManager().getUserId().equals(currentUserId);

        boolean isUser =
                bill.getUser().getUserId().equals(currentUserId);

        if (!isManager && !isUser) {
            throw new BadRequestException("Không có quyền hủy");
        }

        if (bill.getActualCheckInTime() != null) {
            throw new BadRequestException("Đã check-in không thể hủy");
        }

        if (isUser) {
            bill.setCancelReason(Bill.CancelReason.USER_CANCEL);
        }

        if (isManager) {
            bill.setCancelReason(Bill.CancelReason.HOTEL_CANCEL);
        }

        bill.setBillStatus(Bill.BillStatus.CANCELED);
        bill.setUpdatedAt(LocalDateTime.now());

        return toResponse(billRepository.save(bill));
    }

    @Override
    public BillResponse checkIn(Long billId) {

        Bill bill = getBill(billId);

        checkManagerPermission(bill);

        if (bill.getBillStatus() != Bill.BillStatus.PAID) {
            throw new BadRequestException("Chưa thanh toán");
        }

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime allowTime = bill.getCheckInDate().atTime(14, 0);

        if (now.isBefore(allowTime)) {
            throw new BadRequestException("Chỉ được check-in từ 14h");
        }

        for (BillDetail bd : bill.getBillDetails()) {

            List<Room> availableRooms = roomRepository.findAvailableRoomsByType(
                    bd.getRoomType().getTypeId(),
                    bill.getCheckInDate(),
                    bill.getCheckOutDate()
            );

            if (availableRooms.size() < bd.getQuantity()) {
                throw new BadRequestException("Không đủ phòng để gán");
            }

            int assigned = 0;

            for (Room room : availableRooms) {

                try {
                    roomAssignmentService.assignRoom(bd, room);
                    assigned++;

                    if (assigned == bd.getQuantity()) {
                        break;
                    }

                } catch (Exception e) {
                    // skip phòng lỗi
                }
            }

            if (assigned < bd.getQuantity()) {
                throw new BadRequestException("Không đủ phòng hợp lệ để gán");
            }
        }

        bill.setActualCheckInTime(now);
        bill.setUpdatedAt(now);

        return toResponse(billRepository.save(bill));
    }

    @Override
    public BillResponse checkOut(Long billId) {

        Bill bill = getBill(billId);

        checkManagerPermission(bill);

        if (bill.getActualCheckInTime() == null) {
            throw new BadRequestException("Chưa check-in");
        }

        LocalDateTime now = LocalDateTime.now();

        bill.setActualCheckOutTime(now);
        bill.setUpdatedAt(now);

        return toResponse(billRepository.save(bill));
    }


    @Scheduled(fixedRate = 60000)
    public void autoCancelExpiredVnpayBills() {

        LocalDateTime timeout =
                LocalDateTime.now().minusMinutes(1);

        List<Bill> bills =
                billRepository.findByBillStatusAndCreatedAtBefore(
                        Bill.BillStatus.PENDING,
                        timeout
                );

        for (Bill bill : bills) {

            if (bill.getPaymentMethod()
                    == Bill.PaymentMethod.VNPAY) {

                bill.setBillStatus(
                        Bill.BillStatus.CANCELED
                );


                bill.setCancelReason(
                        Bill.CancelReason.VNPAY_CANCEL
                );

                bill.setUpdatedAt(
                        LocalDateTime.now()
                );
            }
        }

        billRepository.saveAll(bills);
    }

    @Override
    public BillResponse getById(Long id) {
        return toResponse(getBill(id));
    }

    private Bill getBill(Long id) {
        return billRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bill không tồn tại"));
    }

    @Override
    public List<BillResponse> getByUser(Long userId) {
        return billRepository.findByUser_UserId(userId)
                .stream()
                .map(this::toResponse)
                .toList();
    }

    private String generateBillCode() {

        String prefix = "BLB";

        String datePart = java.time.LocalDate.now()
                .format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMdd"));

        while (true) {

            int random = ThreadLocalRandom.current()
                    .nextInt(10000, 100000); // 5 số

            String code = prefix + datePart + random;

            if (!billRepository.existsByBillCode(code)) {
                return code;
            }
        }
    }
}