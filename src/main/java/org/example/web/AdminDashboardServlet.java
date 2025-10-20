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
        /* metrics */
        req.setAttribute("totalPatients", dashboardService.totalPatients());
        req.setAttribute("totalDoctors", dashboardService.totalDoctors());
        req.setAttribute("totalAppointments", dashboardService.totalAppointments());
        req.setAttribute("cancellationRate", String.format("%.1f", dashboardService.cancellationRateLastDays(30)));
        req.setAttribute("upcomingAppointments", dashboardService.upcomingAppointments(10));

        /* lists used by the existing JSP */
        req.setAttribute("departments", departmentService.findAll());
        req.setAttribute("specialities", specialityService.findAll());

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}