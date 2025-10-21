package org.example.Servlets;

import org.example.dto.AppointmentDTO;
import org.example.service.AppointmentService;
import org.example.service.DoctorService;
import org.example.service.PatientService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/appointments/new")
public class AppointmentCreateServlet extends HttpServlet {

    @Inject
    AppointmentService appointmentService;

    @Inject
    DoctorService doctorService;

    @Inject
    PatientService patientService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("doctors", doctorService.findAll());
        req.setAttribute("patients", patientService.findAll());
        req.setAttribute("dto", new AppointmentDTO());
        req.getRequestDispatcher("/admin/appointmentForm.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        AppointmentDTO dto = new AppointmentDTO();
        dto.setDoctorId(Long.valueOf(req.getParameter("doctorId")));
        dto.setPatientId(Long.valueOf(req.getParameter("patientId")));
        try {
            dto.setDateRdv(java.time.LocalDate.parse(req.getParameter("dateRdv")));
            dto.setHeureRdv(java.time.LocalTime.parse(req.getParameter("heureRdv")));
        } catch (Exception e) {
            req.setAttribute("error", "Invalid date/time format");
            doGet(req, resp);
            return;
        }
        String type = req.getParameter("type");
        if (type != null && !type.isEmpty()) {
            dto.setType(org.example.entities.enums.AppointmentType.valueOf(type));
        }
        dto.setMotif(req.getParameter("motif"));
        String duree = req.getParameter("dureeMinutes");
        if (duree != null && !duree.isEmpty()) dto.setDureeMinutes(Integer.valueOf(duree));

        try {
            appointmentService.create(dto);
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp?msg=appointment-created");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}
