package org.example.Servlets;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.AvailabilityService;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;

@WebServlet("/admin/availability/generate")
public class AvailabilityGenerateServlet extends HttpServlet {

    @Inject
    AvailabilityService service;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Long doctorId = Long.valueOf(req.getParameter("doctorId"));
        LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));
        
        // Validation: endDate doit être >= startDate
        if (endDate.isBefore(startDate)) {
            req.getSession().setAttribute("error", "La date de fin doit être supérieure ou égale à la date de début");
            resp.sendRedirect(req.getContextPath() + "/doctor/schedule?doctorId=" + doctorId);
            return;
        }

        // Générer les disponibilités pour chaque jour entre startDate et endDate
        LocalDate currentDate = startDate;
        while (!currentDate.isAfter(endDate)) {
            DayOfWeek day = currentDate.getDayOfWeek();
            
            // Générer les créneaux pour ce jour spécifique
            service.generateDefaultSlots(doctorId, day, currentDate, currentDate);
            
            // Passer au jour suivant
            currentDate = currentDate.plusDays(1);
        }

        resp.sendRedirect(req.getContextPath() + "/doctor/schedule?doctorId=" + doctorId + "&msg=generated");
    }
}