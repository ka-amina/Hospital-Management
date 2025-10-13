package org.example.mapper;

import org.example.dto.SpecialityDTO;
import org.example.entities.Department;
import org.example.entities.Speciality;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SpecialityMapper {
    @Inject
    private DepartmentMapper departmentMapper;

    public SpecialityDTO toDto(Speciality s) {
        return SpecialityDTO.builder()
                .id(s.getId())
                .code(s.getCode())
                .nom(s.getNom())
                .description(s.getDescription())
                .departmentId(s.getDepartment().getId())
                .departmentName(s.getDepartment().getNom())
                .build();
    }

    public Speciality toEntity(SpecialityDTO dto, Department dept) {
        Speciality s = new Speciality();
        s.setCode(dto.getCode().trim().toUpperCase());
        s.setNom(dto.getNom().trim());
        s.setDescription(dto.getDescription());
        s.setDepartment(dept);
        return s;
    }
}