package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Appointment;
import org.example.entities.Patient;
import org.example.service.AppointmentService;

import java.io.IOException;

@WebServlet("/patient/appointments/cancel")
public class PatientCancelAppointmentServlet extends HttpServlet {

    @Inject
    AppointmentService appointmentService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object authUser = req.getSession().getAttribute("authUser");
        if (!(authUser instanceof Patient)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        Patient p = (Patient) authUser;
        Long apptId = Long.valueOf(req.getParameter("appointmentId"));
        try {
            appointmentService.cancelIfAllowed(apptId);
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard?msg=cancelled");
        } catch (Exception e) {
            req.getSession().setAttribute("error", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
