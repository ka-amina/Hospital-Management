package org.example.mapper;

import org.example.dto.DoctorDTO;
import org.example.entities.Doctor;
import org.example.entities.Speciality;
import org.example.repository.SpecialityRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class DoctorMapper {

    @Inject
    SpecialityRepository specialityRepository;

    public DoctorDTO toDto(Doctor d) {
        DoctorDTO dto = new DoctorDTO();
        dto.setId(d.getId());
        dto.setNom(d.getNom());
        dto.setEmail(d.getEmail());
        dto.setMatricule(d.getMatricule());
        dto.setTitre(d.getTitre());
        dto.setActif(d.getActif());
        if (d.getSpecialty() != null) {
            Speciality s = d.getSpecialty();
            dto.setSpecialtyId(s.getId());
            dto.setSpecialtyName(s.getNom());
            dto.setDepartmentId(s.getDepartment().getId());
            dto.setDepartmentName(s.getDepartment().getNom());
        }
        return dto;
    }

    public Doctor toEntity(DoctorDTO dto) {
        Doctor d = new Doctor();
        d.setNom(dto.getNom());
        d.setEmail(dto.getEmail());
        d.setPassword("TODO_HASHED");
        d.setMatricule(dto.getMatricule());
        d.setTitre(dto.getTitre());
        d.setActif(dto.getActif());
        Speciality s = specialityRepository.findById(dto.getSpecialtyId())
                .orElseThrow(() -> new RuntimeException("Speciality not found"));
        d.setSpecialty(s);
        return d;
    }

    public void updateEntityFromDto(DoctorDTO dto, Doctor d) {
        d.setNom(dto.getNom());
        d.setEmail(dto.getEmail());
        d.setMatricule(dto.getMatricule());
        d.setTitre(dto.getTitre());
        d.setActif(dto.getActif());
        Speciality s = specialityRepository.findById(dto.getSpecialtyId())
                .orElseThrow(() -> new RuntimeException("Speciality not found"));
        d.setSpecialty(s);
    }
}