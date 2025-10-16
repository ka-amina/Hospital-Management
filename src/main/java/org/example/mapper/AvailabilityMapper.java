package org.example.mapper;

import org.example.dto.AvailabilityDTO;
import org.example.entities.Availability;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class AvailabilityMapper {

    public AvailabilityDTO toDto(Availability a) {
        AvailabilityDTO dto = new AvailabilityDTO();
        dto.setId(a.getId());
        dto.setDoctorId(a.getDoctor().getId());
        dto.setDoctorName(a.getDoctor().getNom());
        dto.setJourSemaine(a.getDay());
        dto.setHeureDebut(a.getStartTime());
        dto.setHeureFin(a.getEndTime());
        dto.setStatut(a.getStatus().name());
        return dto;
    }

    /* No toEntity() – we create the entity directly in service */
}