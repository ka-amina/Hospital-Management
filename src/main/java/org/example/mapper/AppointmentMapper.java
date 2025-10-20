package org.example.mapper;

import org.example.dto.AppointmentDTO;
import org.example.entities.Appointment;
import org.example.entities.Doctor;
import org.example.entities.Patient;
import org.example.repository.DoctorRepository;
import org.example.repository.PatientRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class AppointmentMapper {

    @Inject
    PatientRepository patientRepository;

    @Inject
    DoctorRepository doctorRepository;

    public AppointmentDTO toDto(Appointment a) {
        AppointmentDTO dto = new AppointmentDTO();
        dto.setId(a.getId());
        if (a.getPatient() != null) {
            dto.setPatientId(a.getPatient().getId());
            dto.setPatientName(a.getPatient().getNom());
        }
        if (a.getDoctor() != null) {
            dto.setDoctorId(a.getDoctor().getId());
            dto.setDoctorName(a.getDoctor().getNom());
        }
        dto.setDateRdv(a.getDateRdv());
        dto.setHeureRdv(a.getHeureRdv());
        dto.setType(a.getType());
        dto.setMotif(a.getMotif());
        dto.setDureeMinutes(a.getDureeMinutes());
        return dto;
    }

    public Appointment toEntity(AppointmentDTO dto) {
        Appointment a = new Appointment();
        a.setDateRdv(dto.getDateRdv());
        a.setHeureRdv(dto.getHeureRdv());
        a.setType(dto.getType());
        a.setMotif(dto.getMotif());
        if (dto.getDureeMinutes() != null) a.setDureeMinutes(dto.getDureeMinutes());
        Patient p = patientRepository.findById(dto.getPatientId())
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        Doctor d = doctorRepository.findById(dto.getDoctorId())
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        a.setPatient(p);
        a.setDoctor(d);
        return a;
    }
}
