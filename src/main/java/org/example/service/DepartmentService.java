package org.example.service;

import org.example.dto.DepartmentDTO;
import org.example.entities.Department;
import org.example.mapper.DepartmentMapper;
import org.example.repository.DepartmentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class DepartmentService {
    @Inject
    private DepartmentRepository repository;
    @Inject
    private DepartmentMapper mapper;

    public List<DepartmentDTO> findAll() {
        return repository.findAll().stream().map(mapper::toDto).collect(Collectors.toList());
    }

    public DepartmentDTO findById(Long id) {
        return repository.findById(id).map(mapper::toDto)
                .orElseThrow(() -> new RuntimeException("Department not found"));
    }

    public DepartmentDTO create(DepartmentDTO dto) {
        if (repository.findByCode(dto.getCode()).isPresent())
            throw new RuntimeException("Code already exists");
        Department d = mapper.toEntity(dto);
        repository.create(d);
        return mapper.toDto(d);
    }

    public DepartmentDTO update(Long id, DepartmentDTO dto) {
        Department existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));
        if (!existing.getCode().equalsIgnoreCase(dto.getCode()) && repository.findByCode(dto.getCode()).isPresent())
            throw new RuntimeException("Code already exists");
        existing.setCode(dto.getCode().toUpperCase());
        existing.setNom(dto.getNom());
        existing.setDescription(dto.getDescription());
        return mapper.toDto(repository.update(existing));
    }

    public void delete(Long id) {
        repository.findById(id).orElseThrow(() -> new RuntimeException("Department not found"));
        repository.delete(id);
    }
}