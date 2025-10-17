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
        DayOfWeek day = DayOfWeek.valueOf(req.getParameter("day")); // MONDAY etc.
        LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
        LocalDate endDate = startDate;

        service.generateDefaultSlots(doctorId, day, startDate, endDate);

        resp.sendRedirect(req.getContextPath()
                + "/doctor/schedule?doctorId=" + doctorId + "&msg=generated");
    }
}