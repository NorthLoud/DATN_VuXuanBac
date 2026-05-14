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
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;
@Transactional
@Service
@RequiredArgsConstructor
public class BillServiceImpl implements BillService {

    private final BillRepository billRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;
    private final HotelRepository hotelRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final RoomAssignmentService roomAssignmentService;
    private final BillExtraFeeRepository billExtraFeeRepository;

    private BillResponse toResponse(Bill bill) {

        var assignments = roomAssignmentService.getByBill(bill);


        List<BillResponse.RoomItem> rooms = assignments.stream()
                .map(a -> {
                    Double price = a.getBillDetail().getPriceAtBooking() != null ? a.getBillDetail().getPriceAtBooking()
                            : a.getBillDetail().getRoomType().getPrice();
                    return BillResponse.RoomItem.builder()
                            .roomId(a.getRoom().getRoomId())
                            .roomNumber(a.getRoom().getRoomNumber())
                            .roomType(a.getBillDetail().getRoomType().getTypeName())
                            .capacity(a.getBillDetail().getRoomType().getCapacity())
                            .nights(a.getBillDetail().getNights())
                            .guestCount(a.getBillDetail().getGuestCount())
                            .price(price)
                            .subtotal(price * a.getBillDetail().getNights())
                            .build();
                }).toList();

        List<BillResponse.BillDetailItem> details = bill.getBillDetails().stream()
                .map(d -> {
                    Double price = d.getPriceAtBooking() != null ? d.getPriceAtBooking() : d.getRoomType().getPrice();
                    return BillResponse.BillDetailItem.builder()
                            .typeId(d.getRoomType().getTypeId())
                            .typeName(d.getRoomType().getTypeName())
                            .quantity(1)
                            .priceAtBooking(price)
                            .nights(d.getNights())
                            .guestCount(d.getGuestCount())
                            .build();
                }).toList();

        List<BillResponse.ExtraFeeItem> extraFees = new ArrayList<>();
        if (bill.getExtraFees() != null) {
            extraFees = bill.getExtraFees().stream()
                    .map(f -> {
                        BillResponse.ExtraFeeItem item = BillResponse.ExtraFeeItem.builder()
                                .extraFeeId(f.getExtraFeeId())
                                .amount(f.getAmount())
                                .reason(f.getReason())
                                .createdAt(f.getCreatedAt())
                                .isPaid(f.isPaid())
                                .build();
                        return item;
                    })
                    .toList();
        }

        double roomTotal = bill.getBillDetails().stream()
                .mapToDouble(d -> {
                    Double price = d.getPriceAtBooking() != null
                            ? d.getPriceAtBooking()
                            : d.getRoomType().getPrice();

                    int nights = d.getNights() != null ? d.getNights() : 0;

                    return price * nights;
                })
                .sum();

        double extraFeeTotal = extraFees.stream()
                .mapToDouble(f -> f.getAmount() != null ? f.getAmount() : 0)
                .sum();

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
                .roomTotal(roomTotal)
                .extraFeeTotal(extraFeeTotal)
                .totalCost(roomTotal + extraFeeTotal)
                .billStatus(bill.getBillStatus())
                .paymentMethod(bill.getPaymentMethod())
                .cancelReason(bill.getCancelReason())
                .idCardCode(bill.getIdCardCode())
                .guestCount(bill.getBillDetails().stream().mapToInt(d -> d.getGuestCount() != null ? d.getGuestCount() : 0).sum())
                .actualCheckInTime(bill.getActualCheckInTime())
                .actualCheckOutTime(bill.getActualCheckOutTime())
                .createdAt(bill.getCreatedAt())
                .updatedAt(bill.getUpdatedAt())
                .rooms(rooms)
                .details(details)
                .extraFees(extraFees)
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
                request.getCheckOutDate());

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

            int booked = roomRepository.countBookedRooms(
                    roomType.getTypeId(),
                    request.getCheckInDate(),
                    request.getCheckOutDate());

            int available = totalRooms - booked;

            if (available < r.getQuantity()) {
                throw new BadRequestException("Không đủ phòng trống");
            }

            double price = roomType.getPrice();

            for (int i = 0; i < r.getQuantity(); i++) {
                BillDetail bd = BillDetail.builder()
                        .roomType(roomType)
                        .priceAtBooking(price)
                        .nights((int) nights)
                        .guestCount(r.getGuestCount())
                        .build();

                details.add(bd);
                totalCost += price * nights;
            }
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

    private void checkManagerPermission(Bill bill) {

        Long currentUserId = SecurityUtil.getCurrentUserId();

        Long managerId = bill.getHotel().getManager().getUserId();

        if (!managerId.equals(currentUserId)) {

            throw new BadRequestException(
                    "Không có quyền thao tác bill này");
        }
    }

    @Override
    public BillResponse cancel(Long billId) {

        Bill bill = getBill(billId);

        Long currentUserId = SecurityUtil.getCurrentUserId();

        boolean isManager = bill.getHotel().getManager().getUserId().equals(currentUserId);

        boolean isUser = bill.getUser().getUserId().equals(currentUserId);

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
    public BillResponse assignRooms(Long billId, com.example.loudhotel.dto.request.CheckInRequest request) {
        Bill bill = getBill(billId);
        checkManagerPermission(bill);

        if (request != null && request.getRoomIds() != null && !request.getRoomIds().isEmpty()) {
            List<Long> roomIds = request.getRoomIds();
            int totalRequired = bill.getBillDetails().size();

            if (roomIds.size() != totalRequired) {
                throw new BadRequestException(
                        "Số lượng phòng không khớp (" + roomIds.size() + "/" + totalRequired + ")");
            }

            int index = 0;
            roomAssignmentService.deleteByBill(bill);

            for (BillDetail bd : bill.getBillDetails()) {
                Long roomId = roomIds.get(index++);
                Room room = roomRepository.findById(roomId)
                        .orElseThrow(() -> new ResourceNotFoundException("Phòng " + roomId + " không tồn tại"));

                if (!room.getRoomType().getTypeId().equals(bd.getRoomType().getTypeId())) {
                    throw new BadRequestException(
                            "Phòng " + room.getRoomNumber() + " không đúng loại " + bd.getRoomType().getTypeName());
                }

                roomAssignmentService.assignRoom(bd, room);
            }
        }
        bill.setUpdatedAt(LocalDateTime.now());
        return toResponse(billRepository.save(bill));
    }

    @Override
    public BillResponse checkIn(Long billId, com.example.loudhotel.dto.request.CheckInRequest request) {

        Bill bill = getBill(billId);
        checkManagerPermission(bill);

        if (bill.getBillStatus() != Bill.BillStatus.PAID) {
            throw new BadRequestException("Chưa thanh toán");
        }

        // Tự động gán/cập nhật phòng nếu có request roomIds
        if (request != null && request.getRoomIds() != null && !request.getRoomIds().isEmpty()) {
            this.assignRooms(billId, request);
        }

        LocalDateTime now = LocalDateTime.now();
        bill.setActualCheckInTime(now);
        bill.setUpdatedAt(now);

        return toResponse(billRepository.save(bill));
    }

    @Override
    public BillResponse addExtraFee(Long billId, com.example.loudhotel.dto.request.ExtraFeeRequest request) {
        Bill bill = getBill(billId);
        checkManagerPermission(bill);

        BillExtraFee fee = BillExtraFee.builder()
                .bill(bill)
                .amount(request.getAmount())
                .reason(request.getReason())
                .createdAt(LocalDateTime.now())
                .build();

        billExtraFeeRepository.save(fee);

        // Cập nhật total_cost của bill

        bill.setUpdatedAt(LocalDateTime.now());

        return toResponse(billRepository.save(bill));
    }

    @Override
    public BillResponse checkOut(Long billId) {

        Bill bill = getBill(billId);

        checkManagerPermission(bill);

        if (bill.getActualCheckInTime() == null) {
            throw new BadRequestException("Chưa check-in");
        }

        boolean hasUnpaidFees = bill.getExtraFees() != null &&
                bill.getExtraFees().stream().anyMatch(f -> !f.isPaid());

        if (hasUnpaidFees) {
            throw new BadRequestException("Cần thanh toán phụ phí trước khi check-out");
        }

        LocalDateTime now = LocalDateTime.now();

        bill.setActualCheckOutTime(now);
        bill.setUpdatedAt(now);

        // KHÔNG xóa assignment nữa

        return toResponse(billRepository.save(bill));
    }

    @Scheduled(fixedRate = 60000)
    public void autoCancelExpiredVnpayBills() {

        LocalDateTime timeout = LocalDateTime.now().minusMinutes(1);

        List<Bill> bills = billRepository.findByBillStatusAndCreatedAtBefore(
                Bill.BillStatus.PENDING,
                timeout);

        for (Bill bill : bills) {

            if (bill.getPaymentMethod() == Bill.PaymentMethod.VNPAY) {

                bill.setBillStatus(
                        Bill.BillStatus.CANCELED);

                bill.setCancelReason(
                        Bill.CancelReason.VNPAY_CANCEL);

                bill.setUpdatedAt(
                        LocalDateTime.now());
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

    @Override
    public BillResponse pay(Long billId) {
        Bill bill = getBill(billId);
        checkManagerPermission(bill);
        bill.setBillStatus(Bill.BillStatus.PAID);
        bill.setUpdatedAt(LocalDateTime.now());
        return toResponse(billRepository.save(bill));
    }

    @Override
    public BillResponse payExtraFee(Long billId, Long extraFeeId) {

        Bill bill = getBill(billId);

        checkManagerPermission(bill);

        BillExtraFee fee = billExtraFeeRepository.findById(extraFeeId)
                .orElseThrow(() -> new ResourceNotFoundException("Phụ phí không tồn tại"));

        if (!fee.getBill().getBillId().equals(billId)) {
            throw new BadRequestException("Phụ phí không thuộc đơn hàng này");
        }

        fee.setPaid(true);
        billExtraFeeRepository.saveAndFlush(fee);

        // load lại bill mới từ DB
        Bill freshBill = billRepository.findById(billId)
                .orElseThrow(() -> new ResourceNotFoundException("Bill không tồn tại"));

        freshBill.setUpdatedAt(LocalDateTime.now());

        return toResponse(billRepository.save(freshBill));
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