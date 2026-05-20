package com.example.loudhotel.service.impl;

import com.example.loudhotel.dto.response.AdminDashboardDTO;
import com.example.loudhotel.entity.Bill;
import com.example.loudhotel.entity.Hotel;
import com.example.loudhotel.entity.Room;
import com.example.loudhotel.entity.User;
import com.example.loudhotel.repository.*;
import com.example.loudhotel.service.AdminDashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminDashboardServiceImpl implements AdminDashboardService {

    private final BillRepository billRepository;
    private final UserRepository userRepository;
    private final HotelRepository hotelRepository;
    private final RoomRepository roomRepository;
    private final UtilitiesRepository utilitiesRepository;
    private final ReviewRepository reviewRepository;

    @Override
    public AdminDashboardDTO getOverview() {
        AdminDashboardDTO dto = new AdminDashboardDTO();

        List<Bill> bills = billRepository.findAll();
        
        dto.setTotalIncomeHotel(bills.stream()
                .filter(b -> b.getBillStatus() == Bill.BillStatus.PAID)
                .mapToDouble(b -> b.getTotalCost() != null ? b.getTotalCost() : 0.0)
                .sum());
        dto.setTotalCompleted(bills.stream().filter(b -> b.getBillStatus() == Bill.BillStatus.PAID).count());
        dto.setTotalCanceled(bills.stream().filter(b -> b.getBillStatus() == Bill.BillStatus.CANCELED).count());
        
        dto.setTotalUtil(utilitiesRepository.count());

        List<User> users = userRepository.findAll();
        dto.setTotalUser((long) users.size());
        dto.setActiveUser(users.stream().filter(u -> (u.getIsDeleted() == null || !u.getIsDeleted()) && u.getStatus() == User.Status.ACTIVE).count());

        List<Hotel> hotels = hotelRepository.findAll();
        dto.setTotalHotel((long) hotels.size());
        dto.setActiveHotel(hotels.stream().filter(h -> (h.getIsDeleted() == null || !h.getIsDeleted()) && h.getHotelStatus() == Hotel.HotelStatus.ACTIVE).count());

        List<Room> rooms = roomRepository.findAll();
        dto.setTotalRoom((long) rooms.size());
        dto.setActiveRoom(rooms.stream().filter(r -> (r.getIsDeleted() == null || !r.getIsDeleted()) && r.getRoomStatus() == Room.RoomStatus.ACTIVE).count());

        return dto;
    }

    @Override
    public AdminDashboardDTO getChartByRange(LocalDate startDate, LocalDate endDate, Long hotelId) {
        LocalDateTime start = startDate.atStartOfDay();
        LocalDateTime end = endDate.atTime(23, 59, 59);

        List<Bill> bills;
        if (hotelId != null) {
            bills = billRepository.findByHotel_HotelId(hotelId);
        } else {
            bills = billRepository.findAll();
        }

        List<Bill> rangeBills = bills.stream()
                .filter(b -> b.getCreatedAt() != null && !b.getCreatedAt().isBefore(start) && !b.getCreatedAt().isAfter(end))
                .collect(Collectors.toList());

        AdminDashboardDTO dto = new AdminDashboardDTO();
        dto.setIncomeHotel(rangeBills.stream()
                .filter(b -> b.getBillStatus() == Bill.BillStatus.PAID)
                .mapToDouble(b -> b.getTotalCost() != null ? b.getTotalCost() : 0.0)
                .sum());
        dto.setCompleted(rangeBills.stream().filter(b -> b.getBillStatus() == Bill.BillStatus.PAID).count());
        dto.setCanceled(rangeBills.stream().filter(b -> b.getBillStatus() == Bill.BillStatus.CANCELED).count());

        long reviewCount = reviewRepository.findAll().stream()
                .filter(r -> hotelId == null || r.getBill().getHotel().getHotelId().equals(hotelId))
                .filter(r -> r.getCreatedAt() != null && !r.getCreatedAt().isBefore(start) && !r.getCreatedAt().isAfter(end))
                .count();
        dto.setReview(reviewCount);

        return dto;
    }

    @Override
    public AdminDashboardDTO getChartYear(Integer year, Long hotelId) {
        if (year == null) year = LocalDate.now().getYear();
        int finalYear = year;

        List<Bill> bills;
        if (hotelId != null) {
            bills = billRepository.findByHotel_HotelId(hotelId);
        } else {
            bills = billRepository.findAll();
        }

        List<Bill> yearBills = bills.stream()
                .filter(b -> b.getCreatedAt() != null && b.getCreatedAt().getYear() == finalYear)
                .collect(Collectors.toList());

        List<User> yearUsers = userRepository.findAll().stream()
                .filter(u -> u.getCreatedAt() != null && u.getCreatedAt().getYear() == finalYear)
                .collect(Collectors.toList());

        AdminDashboardDTO dto = new AdminDashboardDTO();
        
        List<Double> adminIncome = new ArrayList<>(Collections.nCopies(12, 0.0));
        List<Double> hotelIncome = new ArrayList<>(Collections.nCopies(12, 0.0));
        List<Long> ordersCompleted = new ArrayList<>(Collections.nCopies(12, 0L));
        List<Long> ordersCanceled = new ArrayList<>(Collections.nCopies(12, 0L));
        List<Long> usersList = new ArrayList<>(Collections.nCopies(12, 0L));
        List<Long> managersList = new ArrayList<>(Collections.nCopies(12, 0L));

        for (Bill b : yearBills) {
            int month = b.getCreatedAt().getMonthValue() - 1;
            if (b.getBillStatus() == Bill.BillStatus.PAID) {
                double cost = b.getTotalCost() != null ? b.getTotalCost() : 0.0;
                hotelIncome.set(month, hotelIncome.get(month) + cost);
                adminIncome.set(month, adminIncome.get(month) + cost * 0.1); // Admin takes 10% fee
                ordersCompleted.set(month, ordersCompleted.get(month) + 1);
            } else if (b.getBillStatus() == Bill.BillStatus.CANCELED) {
                ordersCanceled.set(month, ordersCanceled.get(month) + 1);
            }
        }

        for (User u : yearUsers) {
            int month = u.getCreatedAt().getMonthValue() - 1;
            if (u.getRole() == User.Role.USER) {
                usersList.set(month, usersList.get(month) + 1);
            } else if (u.getRole() == User.Role.MANAGER) {
                managersList.set(month, managersList.get(month) + 1);
            }
        }

        dto.setAdminIncome(adminIncome);
        dto.setHotelIncome(hotelIncome);
        dto.setOrdersCompleted(ordersCompleted);
        dto.setOrdersCanceled(ordersCanceled);
        dto.setUsers(usersList);
        dto.setManagers(managersList);

        return dto;
    }
}
