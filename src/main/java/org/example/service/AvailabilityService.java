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

    /* Create default slots for one doctor & one day */
    public void generateDefaultSlots(Long doctorId,
                                     DayOfWeek day,
                                     LocalDate startDate,   // <─ NEW
                                     LocalDate endDate) {   // <─ NEW

        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        List<LocalTime[]> occupied = fetchOccupiedTimes(doctorId, day);

        List<Availability> slots = SlotFactory.generate(doctor, day, occupied,
                startDate, endDate);

        slots.forEach(repository::create);
    }

    /* Helper: query existing appointments for the same day */
    private List<LocalTime[]> fetchOccupiedTimes(Long doctorId, DayOfWeek day) {
        // naive example: convert DayOfWeek → concrete date
        // here we simply return empty list; adapt to your AppointmentRepository
        return List.of();
    }

    public List<SlotRow> buildWeekSlots(Long doctorId,
                                        int weekOffset,
                                        LocalDate startDate,
                                        LocalDate endDate) {

        List<SlotRow> rows = new ArrayList<>();
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        /* Monday of the requested week */
        LocalDate monday = LocalDate.now()
                .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY))
                .plusWeeks(weekOffset);

        /* Loop only working days */
        for (DayOfWeek day : DayOfWeek.values()) {
            if (day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY) continue;

            /* 08:00 – 18:00  30-min slot + 5-min buffer  (skip lunch) */
            for (int slot = 0; slot < 20; slot++) {
                LocalTime start = LocalTime.of(8, 0).plusMinutes(slot * 35);
                LocalTime end = start.plusMinutes(30);

                if (start.getHour() == 13) continue;          // lunch break

                /* 1.  look for an EXISTING database row  */
                Optional<Availability> opt = repository.findSlot(doctorId, day, start);

                /* 2.  only if it exists AND status == AVAILABLE  ->  Libre  */
                if (opt.isPresent() && opt.get().getStatus() == AvailabilityStatus.AVAILABLE) {
                    Availability av = opt.get();
                    rows.add(new SlotRow(av.getId(), day, start, end, AvailabilityStatus.AVAILABLE));
                } else {
                    /* 3.  no row  ->  always Occupé  */
                    rows.add(new SlotRow(null, day, start, end, AvailabilityStatus.UNAVAILABLE));
                }
            }
        }
        return rows;
    }

}