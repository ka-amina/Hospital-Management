package org.example.service;

import org.example.dto.SpecialityDTO;
import org.example.entities.Department;
import org.example.entities.Speciality;
import org.example.mapper.SpecialityMapper;
import org.example.repository.DepartmentRepository;
import org.example.repository.SpecialityRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class SpecialityService {
    @Inject
    private SpecialityRepository repository;
    @Inject
    private DepartmentRepository departmentRepository;
    @Inject
    private SpecialityMapper mapper;

    public List<SpecialityDTO> findAll() {
        return repository.findAll().stream().map(mapper::toDto).collect(Collectors.toList());
    }

    public SpecialityDTO findById(Long id) {
        return repository.findById(id).map(mapper::toDto)
                .orElseThrow(() -> new RuntimeException("Speciality not found"));
    }

    public SpecialityDTO create(SpecialityDTO dto) {
        if (repository.findByCode(dto.getCode()).isPresent())
            throw new RuntimeException("Code already exists");
        Department dept = departmentRepository.findById(dto.getDepartmentId())
                .orElseThrow(() -> new RuntimeException("Department not found"));
        Speciality s = mapper.toEntity(dto, dept);
        repository.create(s);
        return mapper.toDto(s);
    }

    public SpecialityDTO update(Long id, SpecialityDTO dto) {
        Speciality existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Speciality not found"));
        if (!existing.getCode().equalsIgnoreCase(dto.getCode()) && repository.findByCode(dto.getCode()).isPresent())
            throw new RuntimeException("Code already exists");
        Department dept = departmentRepository.findById(dto.getDepartmentId())
                .orElseThrow(() -> new RuntimeException("Department not found"));
        existing.setCode(dto.getCode().toUpperCase());
        existing.setNom(dto.getNom());
        existing.setDescription(dto.getDescription());
        existing.setDepartment(dept);
        return mapper.toDto(repository.update(existing));
    }

    public void delete(Long id) {
        repository.findById(id).orElseThrow(() -> new RuntimeException("Speciality not found"));
        repository.delete(id);
    }
}