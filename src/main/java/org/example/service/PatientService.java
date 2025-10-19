package org.example.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.example.dto.PatientDTO;
import org.example.entities.Patient;
import org.example.repository.PatientRepository;

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
}