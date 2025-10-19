package org.example.repository;

import org.example.entities.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.Optional;

@ApplicationScoped
public class PatientRepository {

    private final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public Optional<Patient> findByEmail(String email) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT p FROM Patient p WHERE p.email = :e", Patient.class)
                    .setParameter("e", email)
                    .getResultStream()
                    .findFirst();
        } finally {
            em.close();
        }
    }

    public Optional<Patient> findByCin(String cin) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT p FROM Patient p WHERE p.cin = :c", Patient.class)
                    .setParameter("c", cin)
                    .getResultStream()
                    .findFirst();
        } finally {
            em.close();
        }
    }

    public Optional<Patient> findById(Long id) {
        EntityManager em = em();
        try {
            return Optional.ofNullable(em.find(Patient.class, id));
        } finally {
            em.close();
        }
    }

    public void create(Patient p) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Patient update(Patient p) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            Patient merged = em.merge(p);
            em.getTransaction().commit();
            return merged;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}