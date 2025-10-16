package org.example.entities;

import org.example.entities.enums.Role;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "doctors")
public class Doctor extends User {

    @Column(name = "matricule", nullable = false, unique = true, length = 20)
    private String matricule;

    @Column(name = "titre", length = 20)
    private String titre;

    @ManyToOne(fetch = FetchType.EAGER)     
    @JoinColumn(name = "specialty_id", nullable = false)
    private Speciality specialty;

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Availability> availabilities = new ArrayList<>();

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL)
    private List<Appointment> appointments = new ArrayList<>();

    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL)
    private List<MedicalNote> medicalNotes = new ArrayList<>();

    public Doctor() {
        super();
        setRole(Role.DOCTOR);
    }

    public Doctor(String nom, String email, String password, String matricule,
                  String titre, Speciality specialty) {
        super(nom, email, password, Role.DOCTOR);
        this.matricule = matricule;
        this.titre = titre;
        this.specialty = specialty;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public Speciality getSpecialty() {
        return specialty;
    }

    public void setSpecialty(Speciality specialty) {
        this.specialty = specialty;
    }

    public List<Availability> getAvailabilities() {
        return availabilities;
    }

    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }

    public List<MedicalNote> getMedicalNotes() {
        return medicalNotes;
    }

    public void setMedicalNotes(List<MedicalNote> medicalNotes) {
        this.medicalNotes = medicalNotes;
    }
}