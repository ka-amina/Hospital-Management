package org.example.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.DayOfWeek;
import java.time.temporal.TemporalAdjusters;

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int week = 0;
        String raw = req.getParameter("week");
        if (raw != null && !raw.isBlank()) {
            try {
                week = Integer.parseInt(raw);
            } catch (NumberFormatException ignore) {
            }
        }
        LocalDate monday = LocalDate.now()
                .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY))
                .plusWeeks(week);

        req.setAttribute("monday", monday);
        req.setAttribute("week", week);
        req.setAttribute("doctorId", req.getParameter("doctorId"));

        req.getRequestDispatcher("/WEB-INF/views/doctor/dashboard.jsp").forward(req, resp);
    }
}