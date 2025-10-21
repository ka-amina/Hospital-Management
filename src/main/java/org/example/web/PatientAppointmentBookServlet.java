package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dto.AppointmentDTO;
import org.example.entities.Availability;
import org.example.entities.Patient;
import org.example.repository.AvailabilityRepository;
import org.example.service.AppointmentService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/patient/appointment/book")
public class PatientAppointmentBookServlet extends HttpServlet {

    @Inject
    AvailabilityRepository availabilityRepository;

    @Inject
    AppointmentService appointmentService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object auth = req.getSession().getAttribute("authUser");
        if (!(auth instanceof Patient)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Patient p = (Patient) auth;

        String rawId = req.getParameter("availabilityId");
        String mondayRaw = req.getParameter("monday");
        if (rawId == null || mondayRaw == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        Long availabilityId = Long.valueOf(rawId);
        LocalDate monday = LocalDate.parse(mondayRaw);

    Availability av = availabilityRepository.findById(availabilityId)
        .orElseThrow(() -> new RuntimeException("Availability not found"));

    // Try to atomically reserve the slot by marking it UNAVAILABLE only if currently AVAILABLE
    boolean reserved = availabilityRepository.markUnavailableIfAvailable(availabilityId);
    if (!reserved) {
        // slot already taken or not available
        resp.sendRedirect(req.getContextPath() + "/patient/dashboard?error=" + java.net.URLEncoder.encode("Slot not available", "UTF-8"));
        return;
    }

        // compute appointment date from monday + day offset
        java.time.DayOfWeek day = av.getDay();
        LocalDate apptDate = monday.plusDays(day.getValue() - 1);

        AppointmentDTO dto = new AppointmentDTO();
        dto.setPatientId(p.getId());
        dto.setDoctorId(av.getDoctor().getId());
        dto.setDateRdv(apptDate);
        dto.setHeureRdv(av.getStartTime());
        dto.setType(org.example.entities.enums.AppointmentType.CONSULTATION);
        dto.setMotif("");

        try {
            appointmentService.create(dto);
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard?msg=appointment-booked");
        } catch (Exception e) {
            // creation failed — revert availability to AVAILABLE
            try {
                availabilityRepository.markAvailableIfUnavailable(availabilityId);
            } catch (Exception ex) {
                // log but continue to propagate original error message
                ex.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
