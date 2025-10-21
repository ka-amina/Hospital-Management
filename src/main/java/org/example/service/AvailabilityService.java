package org.example.service;

import org.example.dto.AvailabilityDTO;
import org.example.entities.Availability;
import org.example.entities.Doctor;
import org.example.entities.enums.AvailabilityStatus;
import org.example.mapper.AvailabilityMapper;
import org.example.repository.AvailabilityRepository;
import org.example.repository.DoctorRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.example.utils.SlotFactory;
import org.example.dto.SlotRow;

import java.time.temporal.TemporalAdjusters;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@ApplicationScoped
public class AvailabilityService {

    @Inject
    AvailabilityRepository repository;
    @Inject
    DoctorRepository doctorRepository;

    public void generateDefaultSlots(Long doctorId,
                                     DayOfWeek day,
                                     LocalDate startDate,
                                     LocalDate endDate) {

        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        List<LocalTime[]> occupied = fetchOccupiedTimes(doctorId, day);

        List<Availability> slots = SlotFactory.generate(doctor, day, occupied,
                startDate, endDate);

        slots.forEach(repository::create);
    }

    private List<LocalTime[]> fetchOccupiedTimes(Long doctorId, DayOfWeek day) {
        return List.of();
    }

    public List<SlotRow> buildWeekSlots(Long doctorId,
                                        int weekOffset,
                                        LocalDate startDate,
                                        LocalDate endDate) {

        List<SlotRow> rows = new ArrayList<>();
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        LocalDate monday = LocalDate.now()
                .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY))
                .plusWeeks(weekOffset);

        for (DayOfWeek day : DayOfWeek.values()) {
            if (day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY) continue;

            LocalTime cursor = LocalTime.of(8, 0);
            while (cursor.isBefore(LocalTime.of(18, 0))) {
                LocalTime start = cursor;
                LocalTime end = start.plusMinutes(30);


                if (start.isBefore(LocalTime.of(14, 0)) && end.isAfter(LocalTime.of(13, 0))) {
                    cursor = LocalTime.of(14, 0);
                    continue;
                }


                java.time.LocalDate slotDate = monday.plusDays(day.getValue() - 1).plusWeeks(weekOffset);

                Optional<Availability> opt = repository.findSlot(doctorId, day, start, slotDate);

                if (opt.isPresent() && opt.get().getStatus() == AvailabilityStatus.AVAILABLE) {
                    Availability av = opt.get();
                    rows.add(new SlotRow(av.getId(), day, start, end, AvailabilityStatus.AVAILABLE));
                } else {
                    rows.add(new SlotRow(null, day, start, end, AvailabilityStatus.UNAVAILABLE));
                }

                cursor = cursor.plusMinutes(35);
            }
        }
        return rows;
    }

}