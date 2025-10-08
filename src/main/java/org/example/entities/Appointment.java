package org.example.entities;

import org.example.entities.enums.AppointmentStatus;
import org.example.entities.enums.AppointmentType;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "appointments")
public class Appointment extends BaseEntity {

    @Column(name = "date_rdv", nullable = false)
    private LocalDate dateRdv;

    @Column(name = "heure_rdv", nullable = false)
    private LocalTime heureRdv;

    @Enumerated(EnumType.STRING)
    @Column(name = "statut", nullable = false, length = 20)
    private AppointmentStatus statut;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", length = 30)
    private AppointmentType type;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @OneToOne(mappedBy = "appointment", cascade = CascadeType.ALL, orphanRemoval = true)
    private MedicalNote medicalNote;

    @Column(name = "motif", columnDefinition = "TEXT")
    private String motif;

    @Column(name = "duree_minutes")
    private Integer dureeMinutes = 30;

    public Appointment() {
    }

    public Appointment(LocalDate dateRdv, LocalTime heureRdv, Patient patient,
                       Doctor doctor, AppointmentType type) {
        this.dateRdv = dateRdv;
        this.heureRdv = heureRdv;
        this.patient = patient;
        this.doctor = doctor;
        this.type = type;
        this.statut = AppointmentStatus.PLANNED;
        this.dureeMinutes = 30;
    }

    public LocalDate getDateRdv() {
        return dateRdv;
    }

    public void setDateRdv(LocalDate dateRdv) {
        this.dateRdv = dateRdv;
    }

    public LocalTime getHeureRdv() {
        return heureRdv;
    }

    public void setHeureRdv(LocalTime heureRdv) {
        this.heureRdv = heureRdv;
    }

    public AppointmentStatus getStatut() {
        return statut;
    }

    public void setStatut(AppointmentStatus statut) {
        this.statut = statut;
    }

    public AppointmentType getType() {
        return type;
    }

    public void setType(AppointmentType type) {
        this.type = type;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public MedicalNote getMedicalNote() {
        return medicalNote;
    }

    public void setMedicalNote(MedicalNote medicalNote) {
        this.medicalNote = medicalNote;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public Integer getDureeMinutes() {
        return dureeMinutes;
    }

    public void setDureeMinutes(Integer dureeMinutes) {
        this.dureeMinutes = dureeMinutes;
    }
}