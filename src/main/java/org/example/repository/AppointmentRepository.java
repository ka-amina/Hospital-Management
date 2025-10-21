package org.example.repository;

import org.example.entities.Appointment;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.Optional;

@ApplicationScoped
public class AppointmentRepository {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public Optional<Appointment> findById(Long id) {
        EntityManager em = em();
        try {
            return Optional.ofNullable(em.find(Appointment.class, id));
        } finally {
            em.close();
        }
    }

    public void create(Appointment a) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            em.persist(a);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public java.util.List<Appointment> findUpcomingByPatient(Long patientId) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT a FROM Appointment a JOIN FETCH a.doctor d WHERE a.patient.id = :pid AND (a.dateRdv > :today OR (a.dateRdv = :today)) ORDER BY a.dateRdv, a.heureRdv", Appointment.class).setParameter("pid", patientId).setParameter("today", java.time.LocalDate.now()).getResultList();
        } finally {
            em.close();
        }
    }

    public java.util.List<Appointment> findHistoryByPatient(Long patientId) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT a FROM Appointment a JOIN FETCH a.doctor d WHERE a.patient.id = :pid AND a.dateRdv < :today ORDER BY a.dateRdv DESC", Appointment.class).setParameter("pid", patientId).setParameter("today", java.time.LocalDate.now()).getResultList();
        } finally {
            em.close();
        }
    }

    public boolean cancelAppointment(Long appointmentId) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            int updated = em.createQuery("UPDATE Appointment a SET a.statut = :s WHERE a.id = :id").setParameter("s", org.example.entities.enums.AppointmentStatus.CANCELED).setParameter("id", appointmentId).executeUpdate();
            em.getTransaction().commit();
            return updated == 1;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
