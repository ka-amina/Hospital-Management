package org.example.entities;

import org.example.entities.enums.BloodType;
import org.example.entities.enums.Gender;
import org.example.entities.enums.Role;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.*;

@Entity
@Table(name = "patients")
public class Patient extends User {

    @Column(name = "cin", unique = true, length = 20)
    private String cin;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Enumerated(EnumType.STRING)
    @Column(name = "sexe", length = 10)
    private Gender sexe;

    @Column(name = "adresse", length = 255)
    private String adresse;

    @Column(name = "telephone", length = 20)
    private String telephone;

    @Enumerated(EnumType.STRING)
    @Column(name = "groupe_sanguin", length = 10)
    private BloodType groupeSanguin;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Appointment> appointments = new ArrayList<>();

    public Patient() {
        super();
        setRole(Role.PATIENT);
    }

    public Patient(String nom, String email, String password, String cin,
                   LocalDate dateNaissance, Gender sexe) {
        super(nom, email, password, Role.PATIENT);
        this.cin = cin;
        this.dateNaissance = dateNaissance;
        this.sexe = sexe;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Gender getSexe() {
        return sexe;
    }

    public void setSexe(Gender sexe) {
        this.sexe = sexe;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public BloodType getGroupeSanguin() {
        return groupeSanguin;
    }

    public void setGroupeSanguin(BloodType groupeSanguin) {
        this.groupeSanguin = groupeSanguin;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }
}