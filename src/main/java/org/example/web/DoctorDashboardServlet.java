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

        /* 1.  same week calculation as DoctorScheduleServlet */
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

        /* 2.  push to JSP */
        req.setAttribute("monday", monday);
        req.setAttribute("week", week);
        /* if you need doctorId in the JSP links, push it too */
        req.setAttribute("doctorId", req.getParameter("doctorId"));

        req.getRequestDispatcher("/WEB-INF/views/doctor/dashboard.jsp").forward(req, resp);
    }
}