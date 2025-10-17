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
import java.time.temporal.TemporalAdjusters;
import java.util.Set;

@WebServlet("/doctor/schedule")
public class DoctorScheduleServlet extends HttpServlet {

    @Inject
    AvailabilityService availabilityService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        /* ---- 1.  doctorId : mandatory ---- */
        String rawId = req.getParameter("doctorId");
        if (rawId == null || rawId.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Paramètre 'doctorId' manquant. Ex : /doctor/schedule?doctorId=25");
            return;
        }
        Long doctorId = Long.valueOf(rawId);

        int week = 0;
        String rawWeek = req.getParameter("week");
        if (rawWeek != null && !rawWeek.isBlank()) {
            try {
                week = Integer.parseInt(rawWeek);
            } catch (NumberFormatException ignore) {
                week = 0;
            }
        }

        /* ---- 3.  compute Monday-Friday for the requested week ---- */
        LocalDate monday = LocalDate.now()
                .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY))
                .plusWeeks(week);
        req.setAttribute("monday", monday);
        LocalDate friday = monday.plusDays(4);

        /* ---- 4.  build the view ---- */
        req.setAttribute("doctorId", doctorId);
        req.setAttribute("week", week);
        req.setAttribute("slots",
                availabilityService.buildWeekSlots(doctorId, week, monday, friday));
        req.setAttribute("bookedIds", Set.of());
        req.getRequestDispatcher("/admin/schedule.jsp").forward(req, resp);
    }
}