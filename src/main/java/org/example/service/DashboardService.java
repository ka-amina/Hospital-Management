package org.example.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.example.entities.Appointment;
import org.example.repository.DashboardRepository;

import java.time.LocalDate;
import java.util.List;

@ApplicationScoped
public class DashboardService {

    @Inject
    DashboardRepository repository;

    public long totalPatients() { return repository.countPatients(); }
    public long totalDoctors() { return repository.countDoctors(); }
    public long totalAppointments() { return repository.countAppointments(); }

    public double cancellationRateLastDays(int days) {
        LocalDate since = LocalDate.now().minusDays(days);
        long canceled = repository.countCanceledAppointmentsSince(since);
        long total = repository.countAppointments();
        if (total == 0) return 0.0;
        return (canceled * 100.0) / total;
    }

    public List<Appointment> upcomingAppointments(int limit) { return repository.findUpcomingAppointments(limit); }
}
