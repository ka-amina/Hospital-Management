package org.example.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.example.dto.PatientDTO;
import org.example.entities.Patient;
import org.example.repository.PatientRepository;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class PatientService {

    @Inject
    PatientRepository repository;

    public Patient register(PatientDTO dto) {
        /* uniqueness checks */
        if (repository.findByEmail(dto.getEmail()).isPresent())
            throw new RuntimeException("Email déjà utilisé");
        if (repository.findByCin(dto.getCin()).isPresent())
            throw new RuntimeException("CIN déjà utilisé");

        /* plain-text password (or hash if you want) */
        Patient p = new Patient();
        p.setNom(dto.getNom());
        p.setEmail(dto.getEmail());
        p.setPassword(dto.getPassword());
        p.setCin(dto.getCin());
        p.setDateNaissance(dto.getDateNaissance());
        p.setSexe(dto.getSexe());
        p.setActif(true);

        repository.create(p);
        return p;
    }

    public List<PatientDTO> findAll() {
        return repository.findAll().stream().map(p -> {
            PatientDTO dto = new PatientDTO();
            dto.setId(p.getId());
            dto.setNom(p.getNom());
            dto.setEmail(p.getEmail());
            dto.setCin(p.getCin());
            dto.setDateNaissance(p.getDateNaissance());
            dto.setSexe(p.getSexe());
            return dto;
        }).collect(Collectors.toList());
    }
}