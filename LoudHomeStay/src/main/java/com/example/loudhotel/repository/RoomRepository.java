package com.example.loudhotel.repository;

import com.example.loudhotel.entity.Hotel;
import com.example.loudhotel.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface RoomRepository extends JpaRepository<Room, Long> {

    boolean existsByHotelAndRoomNumberAndIsDeletedFalse(Hotel hotel, Integer roomNumber);

    List<Room> findByIsDeletedFalse();

    List<Room> findByHotelAndIsDeletedFalse(Hotel hotel);

    long countByHotelAndIsDeletedFalse(Hotel hotel);

    @Query("""
SELECT r FROM Room r
WHERE r.isDeleted = false
AND r.hotel.isDeleted = false
""")
    List<Room> findAllActiveRooms();

    @Query("""
SELECT r FROM Room r
WHERE r.hotel = :hotel
AND r.isDeleted = false
AND r.hotel.isDeleted = false
""")
    List<Room> findActiveByHotel(Hotel hotel);

    @Query("""
SELECT r FROM Room r
WHERE r.isDeleted = false
AND r.hotel.isDeleted = false
AND r.hotel.manager.userId = :managerId
""")
    List<Room> findByManagerId(Long managerId);

    @Query(
            "SELECT r FROM Room r " +
                    "WHERE r.roomType.typeId = :typeId " +
                    "AND r.isDeleted = false " +
                    "AND r.roomStatus = 'ACTIVE' " +
                    "AND r.hotel.isDeleted = false " +
                    "AND NOT EXISTS ( " +
                    "   SELECT 1 FROM RoomAssignment ra " +
                    "   JOIN ra.billDetail bd " +
                    "   JOIN bd.bill b " +
                    "   WHERE ra.room = r " +
                    "   AND ( " +
                    "       (b.actualCheckInTime IS NOT NULL AND b.actualCheckOutTime IS NULL) " +
                    "       OR " +
                    "       (b.checkInDate < :checkOut AND b.checkOutDate > :checkIn) " +
                    "   ) " +
                    ")"
    )
    List<Room> findAvailableRoomsByType(
            @Param("typeId") Long typeId,
            @Param("checkIn") LocalDate checkIn,
            @Param("checkOut") LocalDate checkOut
    );

    boolean existsByRoomType_TypeIdAndIsDeletedFalse(Long typeId);

    int countByRoomType_TypeId(Long typeId);
}
