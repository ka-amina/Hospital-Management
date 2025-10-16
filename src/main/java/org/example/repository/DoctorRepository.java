package org.example.repository;

import org.example.entities.Doctor;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;

@ApplicationScoped
public class DoctorRepository {

    private final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public List<Doctor> findAll() {
        return em().createQuery(
                        "SELECT d FROM Doctor d " +
                                "JOIN FETCH d.specialty s " +      // <--  specialty  (not speciality)
                                "JOIN FETCH s.department " +
                                "ORDER BY d.nom", Doctor.class)
                .getResultList();
    }

    public Optional<Doctor> findById(Long id) {
        EntityManager em = em();
        try {
            return em.createQuery(
                            "SELECT d FROM Doctor d " +
                                    "JOIN FETCH d.specialty s " +
                                    "JOIN FETCH s.department " +
                                    "WHERE d.id = :id", Doctor.class)
                    .setParameter("id", id)
                    .getResultStream()
                    .findFirst();
        } finally {
            em.close();
        }
    }

    public Optional<Doctor> findByMatricule(String matricule) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT d FROM Doctor d WHERE d.matricule = :m", Doctor.class)
                    .setParameter("m", matricule)
                    .getResultStream().findFirst();
        } finally {
            em.close();
        }
    }

    public Optional<Doctor> findByEmail(String email) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT d FROM Doctor d WHERE d.email = :e", Doctor.class)
                    .setParameter("e", email)
                    .getResultStream().findFirst();
        } finally {
            em.close();
        }
    }

    public void create(Doctor d) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            em.persist(d);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Doctor update(Doctor d) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            Doctor merged = em.merge(d);
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
            int rows = em.createQuery("UPDATE Doctor d SET d.actif = false WHERE d.id = :id")
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


    public <R> R withinTransaction(Function<EntityManager, R> action) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            R result = action.apply(em);
            em.getTransaction().commit();
            return result;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Doctor findByIdAttached(Long id, EntityManager em) {
        return em.createQuery(
                        "SELECT d FROM Doctor d " +
                                "JOIN FETCH d.specialty s " +
                                "WHERE d.id = :id", Doctor.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    public boolean existsByMatriculeAndNotId(String mat, Long id, EntityManager em) {
        return em.createQuery(
                        "SELECT COUNT(d)>0 FROM Doctor d WHERE d.matricule=:m AND d.id<>:id", Boolean.class)
                .setParameter("m", mat)
                .setParameter("id", id)
                .getSingleResult();
    }

    public boolean existsByEmailAndNotId(String email, Long id, EntityManager em) {
        return em.createQuery(
                        "SELECT COUNT(d)>0 FROM Doctor d WHERE d.email = :e AND d.id <> :id", Boolean.class)
                .setParameter("e", email)
                .setParameter("id", id)
                .getSingleResult();
    }
}