package org.example.repository;

import org.example.entities.Speciality;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class SpecialityRepository {
    private final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public List<Speciality> findAll() {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT s FROM Speciality s JOIN FETCH s.department ORDER BY s.nom", Speciality.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Speciality> findById(Long id) {
        EntityManager em = em();
        try {
            return Optional.ofNullable(em.find(Speciality.class, id));
        } finally {
            em.close();
        }
    }

    public Optional<Speciality> findByCode(String code) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT s FROM Speciality s WHERE s.code = :code", Speciality.class)
                    .setParameter("code", code).getResultStream().findFirst();
        } finally {
            em.close();
        }
    }

    public void create(Speciality s) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            em.persist(s);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Speciality update(Speciality s) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            Speciality merged = em.merge(s);
            em.getTransaction().commit();
            return merged;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public boolean delete(Long id) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            int rows = em.createQuery("DELETE FROM Speciality s WHERE s.id = :id")
                    .setParameter("id", id).executeUpdate();
            em.getTransaction().commit();
            return rows == 1;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}