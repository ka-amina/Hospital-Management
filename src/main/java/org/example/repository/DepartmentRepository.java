package org.example.repository;

import org.example.entities.Department;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class DepartmentRepository {
    private final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public List<Department> findAll() {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT d FROM Department d ORDER BY d.nom", Department.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Department> findById(Long id) {
        EntityManager em = em();
        try {
            return Optional.ofNullable(em.find(Department.class, id));
        } finally {
            em.close();
        }
    }

    public Optional<Department> findByCode(String code) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT d FROM Department d WHERE d.code = :code", Department.class)
                    .setParameter("code", code).getResultStream().findFirst();
        } finally {
            em.close();
        }
    }

    public void create(Department d) {
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

    public Department update(Department d) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            Department merged = em.merge(d);
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
            int rows = em.createQuery("DELETE FROM Department d WHERE d.id = :id")
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