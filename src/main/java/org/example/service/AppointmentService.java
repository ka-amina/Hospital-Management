package org.example.service;

import org.example.dto.AppointmentDTO;
import org.example.entities.Appointment;
import org.example.mapper.AppointmentMapper;
import org.example.repository.AppointmentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.example.entities.Appointment;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@ApplicationScoped
public class AppointmentService {

    @Inject
    AppointmentRepository repository;

    @Inject
    AppointmentMapper mapper;

    public AppointmentDTO create(AppointmentDTO dto) {
        Appointment a = mapper.toEntity(dto);
        repository.create(a);
        return mapper.toDto(a);
    }

    public List<Appointment> findUpcomingByPatient(Long patientId) {
        return repository.findUpcomingByPatient(patientId);
    }

    public List<Appointment> findHistoryByPatient(Long patientId) {
        return repository.findHistoryByPatient(patientId);
    }

    /**
     * Cancel appointment if allowed (must be at least 12 hours before appointment start)
     */
    public boolean cancelIfAllowed(Long appointmentId) {
        Appointment a = repository.findById(appointmentId).orElseThrow(() -> new RuntimeException("Appointment not found"));
        LocalDate date = a.getDateRdv();
        LocalTime time = a.getHeureRdv();
        LocalDateTime apptDateTime = LocalDateTime.of(date, time);
        if (LocalDateTime.now().plusHours(12).isAfter(apptDateTime)) {
            throw new RuntimeException("Cannot cancel less than 12 hours before appointment");
        }
        return repository.cancelAppointment(appointmentId);
    }
}
