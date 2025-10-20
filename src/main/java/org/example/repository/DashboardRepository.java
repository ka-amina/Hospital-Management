package org.example.repository;

import org.example.entities.Appointment;
import org.example.entities.Doctor;
import org.example.entities.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.time.LocalDate;
import java.util.List;

@ApplicationScoped
public class DashboardRepository {

    private final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public long countPatients() {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT COUNT(p) FROM Patient p", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countDoctors() {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT COUNT(d) FROM Doctor d", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countAppointments() {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT COUNT(a) FROM Appointment a", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countCanceledAppointmentsSince(LocalDate since) {
        EntityManager em = em();
        try {
            return em.createQuery(
                    "SELECT COUNT(a) FROM Appointment a WHERE a.statut = :s AND a.dateRdv >= :since", Long.class)
                    .setParameter("s", org.example.entities.enums.AppointmentStatus.CANCELED)
                    .setParameter("since", since)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public List<Appointment> findUpcomingAppointments(int limit) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT a FROM Appointment a JOIN FETCH a.patient p JOIN FETCH a.doctor d WHERE a.dateRdv >= :today ORDER BY a.dateRdv, a.heureRdv", Appointment.class)
                    .setParameter("today", LocalDate.now())
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
