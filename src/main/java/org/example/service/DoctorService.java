package org.example.service;

import org.example.dto.DoctorDTO;
import org.example.entities.Doctor;
import org.example.entities.Speciality;
import org.example.mapper.DoctorMapper;
import org.example.repository.DoctorRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class DoctorService {

    @Inject
    DoctorRepository repository;
    @Inject
    DoctorMapper mapper;

    public List<DoctorDTO> findAll() {
        return repository.findAll().stream().map(mapper::toDto).collect(Collectors.toList());
    }

    public DoctorDTO findById(Long id) {
        return repository.findById(id).map(mapper::toDto)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
    }

    public DoctorDTO create(DoctorDTO dto) {
        if (repository.findByMatricule(dto.getMatricule()).isPresent())
            throw new RuntimeException("Matricule already exists");
        if (repository.findByEmail(dto.getEmail()).isPresent())
            throw new RuntimeException("Email already exists");
        Doctor d = mapper.toEntity(dto);
        repository.create(d);
        return mapper.toDto(d);
    }

    public DoctorDTO update(Long id, DoctorDTO dto) {
        return repository.withinTransaction(em -> {

            Doctor existing = repository.findByIdAttached(id, em);

            /* uniqueness checks (still via repository methods that use em) */
            if (!existing.getMatricule().equalsIgnoreCase(dto.getMatricule())
                    && repository.existsByMatriculeAndNotId(dto.getMatricule(), id, em))
                throw new RuntimeException("Matricule already exists");

            if (!existing.getEmail().equalsIgnoreCase(dto.getEmail())
                    && repository.existsByEmailAndNotId(dto.getEmail(), id, em))
                throw new RuntimeException("Email already exists");

            /* load new specialty inside same EM */
            Speciality newSpec = em.find(Speciality.class, dto.getSpecialtyId());
            if (newSpec == null) throw new RuntimeException("Speciality not found");

            /* copy fields */
            existing.setNom(dto.getNom());
            existing.setEmail(dto.getEmail());
            existing.setMatricule(dto.getMatricule());
            existing.setTitre(dto.getTitre());
            existing.setActif(dto.getActif());
            existing.setSpecialty(newSpec);

            /* merge + map while still attached */
            Doctor merged = em.merge(existing);
            return mapper.toDto(merged);
        });
    }

    public void delete(Long id) {
        repository.findById(id).orElseThrow(() -> new RuntimeException("Doctor not found"));
        repository.delete(id);
    }
}