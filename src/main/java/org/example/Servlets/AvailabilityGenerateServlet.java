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

        try {
            String doctorIdParam = req.getParameter("doctorId");
            String startDateParam = req.getParameter("startDate");
            String endDateParam = req.getParameter("endDate");

            System.out.println("=== AVAILABILITY GENERATE ===");
            System.out.println("doctorId: " + doctorIdParam);
            System.out.println("startDate: " + startDateParam);
            System.out.println("endDate: " + endDateParam);

            if (doctorIdParam == null || startDateParam == null || endDateParam == null) {
                req.getSession().setAttribute("error", "Paramètres manquants");
                resp.sendRedirect(req.getContextPath() + "/doctor/schedule");
                return;
            }

            Long doctorId = Long.valueOf(doctorIdParam);
            LocalDate startDate = LocalDate.parse(startDateParam);
            LocalDate endDate = LocalDate.parse(endDateParam);
            
            // Validation: endDate doit être >= startDate
            if (endDate.isBefore(startDate)) {
                req.getSession().setAttribute("error", "La date de fin doit être supérieure ou égale à la date de début");
                resp.sendRedirect(req.getContextPath() + "/doctor/schedule?doctorId=" + doctorId);
                return;
            }

            // Générer les disponibilités pour chaque jour entre startDate et endDate
            LocalDate currentDate = startDate;
            int daysGenerated = 0;
            while (!currentDate.isAfter(endDate)) {
                DayOfWeek day = currentDate.getDayOfWeek();
                
                System.out.println("Generating slots for " + currentDate + " (" + day + ")");
                
                // Générer les créneaux pour ce jour spécifique
                service.generateDefaultSlots(doctorId, day, currentDate, currentDate);
                
                daysGenerated++;
                currentDate = currentDate.plusDays(1);
            }

            System.out.println("Total days generated: " + daysGenerated);
            System.out.println("=============================");

            resp.sendRedirect(req.getContextPath() + "/doctor/schedule?doctorId=" + doctorId + "&msg=generated");
            
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Erreur: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/doctor/schedule");
        }
    }
}