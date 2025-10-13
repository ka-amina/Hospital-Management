package org.example.mapper;

import org.example.dto.DepartmentDTO;
import org.example.entities.Department;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DepartmentMapper {
    public DepartmentDTO toDto(Department d) {
        return DepartmentDTO.builder()
                .id(d.getId())
                .code(d.getCode())
                .nom(d.getNom())
                .description(d.getDescription())
                .build();
    }

    public Department toEntity(DepartmentDTO dto) {
        Department d = new Department();
        d.setCode(dto.getCode().trim().toUpperCase());
        d.setNom(dto.getNom().trim());
        d.setDescription(dto.getDescription());
        return d;
    }
}