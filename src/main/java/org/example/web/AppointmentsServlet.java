package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Patient;
import org.example.service.AppointmentService;

import java.io.IOException;

@WebServlet("/appointments")
public class AppointmentsServlet extends HttpServlet {

    @Inject
    AppointmentService appointmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object roleObj = req.getSession().getAttribute("userRole");
        String role = roleObj != null ? roleObj.toString() : null;
        Object auth = req.getSession().getAttribute("authUser");

        if ("ADMIN".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }
        if ("DOCTOR".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/doctor/schedule");
            return;
        }

        if (auth instanceof Patient) {
            Patient p = (Patient) auth;
            req.setAttribute("upcomingAppointments", appointmentService.findUpcomingByPatient(p.getId()));
            req.setAttribute("historyAppointments", appointmentService.findHistoryByPatient(p.getId()));
            req.getRequestDispatcher("/WEB-INF/views/appointments/list.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
