package org.example.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.inject.Inject;
import org.example.entities.Patient;
import org.example.service.AppointmentService;

import java.io.IOException;

@WebServlet("/patient/dashboard")
public class PatientDashboardServlet extends HttpServlet {

    @Inject
    AppointmentService appointmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Object authUser = req.getSession().getAttribute("authUser");
        if (authUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", authUser);
        if (authUser instanceof Patient) {
            Patient p = (Patient) authUser;
            req.setAttribute("upcomingAppointments", appointmentService.findUpcomingByPatient(p.getId()));
            req.setAttribute("historyAppointments", appointmentService.findHistoryByPatient(p.getId()));
        }
        req.getRequestDispatcher("/WEB-INF/views/patient/dashboard.jsp").forward(req, resp);
    }
}
