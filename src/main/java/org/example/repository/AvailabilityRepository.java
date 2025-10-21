package org.example.repository;

import org.example.entities.Availability;
import org.example.entities.enums.AvailabilityStatus;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class AvailabilityRepository {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("CliniqueDigitalePU");

    private EntityManager em() {
        return emf.createEntityManager();
    }

    public List<Availability> findByDoctor(Long doctorId) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT a FROM Availability a " + "JOIN FETCH a.doctor " + "WHERE a.doctor.id = :doc " + "ORDER BY a.startDate, a.startTime", Availability.class).setParameter("doc", doctorId).getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Availability> findById(Long id) {
        EntityManager em = em();
        try {
            return Optional.ofNullable(em.find(Availability.class, id));
        } finally {
            em.close();
        }
    }

    public Optional<Availability> findOverlap(Long doctorId, DayOfWeek day, LocalTime debut, LocalTime fin) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT a FROM Availability a " + "WHERE a.doctor.id = :doc " + "AND a.startDate = :day " + "AND a.status = :status " + "AND ( :debut < a.endTime AND :fin > a.startDate ) ", Availability.class).setParameter("doc", doctorId).setParameter("day", day).setParameter("status", AvailabilityStatus.AVAILABLE).setParameter("debut", debut).setParameter("fin", fin).getResultStream().findFirst();
        } finally {
            em.close();
        }
    }

    public void create(Availability a) {
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

    public Availability update(Availability a) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            Availability merged = em.merge(a);
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
            int rows = em.createQuery("DELETE FROM Availability a WHERE a.id = :id").setParameter("id", id).executeUpdate();
            em.getTransaction().commit();
            return rows == 1;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public boolean markUnavailableIfAvailable(Long id) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            int rows = em.createQuery("UPDATE Availability a SET a.status = :newStatus WHERE a.id = :id AND a.status = :expected").setParameter("newStatus", AvailabilityStatus.UNAVAILABLE).setParameter("expected", AvailabilityStatus.AVAILABLE).setParameter("id", id).executeUpdate();
            em.getTransaction().commit();
            return rows == 1;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public boolean markAvailableIfUnavailable(Long id) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            int rows = em.createQuery("UPDATE Availability a SET a.status = :newStatus WHERE a.id = :id AND a.status = :expected").setParameter("newStatus", AvailabilityStatus.AVAILABLE).setParameter("expected", AvailabilityStatus.UNAVAILABLE).setParameter("id", id).executeUpdate();
            em.getTransaction().commit();
            return rows == 1;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Optional<Availability> findSlot(Long doctorId, DayOfWeek day, LocalTime start, java.time.LocalDate date) {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT a FROM Availability a " + "WHERE a.doctor.id = :doc " + "AND a.day = :day " + "AND a.startTime = :start " + "AND (a.startDate IS NULL OR (:date BETWEEN a.startDate AND a.endDate))", Availability.class).setParameter("doc", doctorId).setParameter("day", day).setParameter("start", start).setParameter("date", date).getResultStream().findFirst();
        } finally {
            em.close();
        }
    }

    /**
     * Find all doctor IDs who have at least one available slot on a specific date
     */
    public List<Long> findDoctorIdsWithAvailabilityOnDate(java.time.LocalDate date) {
        EntityManager em = em();
        try {
            DayOfWeek dayOfWeek = date.getDayOfWeek();
            return em.createQuery(
                    "SELECT DISTINCT a.doctor.id FROM Availability a " +
                    "WHERE a.day = :day " +
                    "AND a.status = :status " +
                    "AND (a.startDate IS NULL OR :date BETWEEN a.startDate AND a.endDate)",
                    Long.class)
                    .setParameter("day", dayOfWeek)
                    .setParameter("status", AvailabilityStatus.AVAILABLE)
                    .setParameter("date", date)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}