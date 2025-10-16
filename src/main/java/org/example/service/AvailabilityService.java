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

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class AvailabilityService {

    @Inject
    AvailabilityRepository repository;
    @Inject
    DoctorRepository doctorRepository;
    @Inject
    AvailabilityMapper mapper;

    public List<AvailabilityDTO> findByDoctor(Long doctorId) {
        return repository.findByDoctor(doctorId)
                .stream()
                .map(mapper::toDto)
                .collect(Collectors.toList());
    }

    public AvailabilityDTO addSlot(Long doctorId, DayOfWeek day,
                                   LocalTime debut, LocalTime fin) {
        if (debut.isAfter(fin) || debut.equals(fin))
            throw new RuntimeException("Heure de début doit être avant heure de fin");

        if (repository.findOverlap(doctorId, day, debut, fin).isPresent())
            throw new RuntimeException("Chevauchement détecté – créneau impossible");

        Doctor d = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        Availability a = new Availability(d, day, debut, fin, AvailabilityStatus.AVAILABLE);
        repository.create(a);
        return mapper.toDto(a);
    }

    public void deleteSlot(Long slotId) {
        repository.findById(slotId)
                .orElseThrow(() -> new RuntimeException("Slot not found"));
        repository.delete(slotId);
    }
}