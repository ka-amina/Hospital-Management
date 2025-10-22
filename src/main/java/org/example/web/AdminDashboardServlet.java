package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.DashboardService;
import org.example.service.DepartmentService;
import org.example.service.SpecialityService;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Inject
    DashboardService dashboardService;

    @Inject
    private DepartmentService departmentService;

    @Inject
    private SpecialityService specialityService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long totalPatients = dashboardService.totalPatients();
        long totalDoctors = dashboardService.totalDoctors();
        long totalAppointments = dashboardService.totalAppointments();
        double cancellationRate = dashboardService.cancellationRateLastDays(30);
        var upcomingAppointments = dashboardService.upcomingAppointments(10);

        // Debug logging
        System.out.println("=== ADMIN DASHBOARD ===");
        System.out.println("Total Patients: " + totalPatients);
        System.out.println("Total Doctors: " + totalDoctors);
        System.out.println("Total Appointments: " + totalAppointments);
        System.out.println("Cancellation Rate: " + String.format("%.1f", cancellationRate) + "%");
        System.out.println("Upcoming Appointments Count: " + (upcomingAppointments != null ? upcomingAppointments.size() : 0));
        if (upcomingAppointments != null && !upcomingAppointments.isEmpty()) {
            System.out.println("First appointment: " + upcomingAppointments.get(0).getDateRdv() + " at " + upcomingAppointments.get(0).getHeureRdv());
        }

        req.setAttribute("totalPatients", totalPatients);
        req.setAttribute("totalDoctors", totalDoctors);
        req.setAttribute("totalAppointments", totalAppointments);
        req.setAttribute("cancellationRate", String.format("%.1f", cancellationRate));
        req.setAttribute("upcomingAppointments", upcomingAppointments);

        req.setAttribute("departments", departmentService.findAll());
        req.setAttribute("specialities", specialityService.findAll());

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}