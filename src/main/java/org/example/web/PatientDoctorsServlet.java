package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dto.DoctorDTO;
import org.example.dto.DepartmentDTO;
import org.example.service.DoctorService;
import org.example.service.DepartmentService;
import org.example.repository.AvailabilityRepository;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/patient/doctors")
public class PatientDoctorsServlet extends HttpServlet {

    @Inject
    DoctorService doctorService;

    @Inject
    DepartmentService departmentService;

    @Inject
    AvailabilityRepository availabilityRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get all departments for filter dropdown
        List<DepartmentDTO> departments = departmentService.findAll();
        req.setAttribute("departments", departments);

        // Get filter parameters
        String nameFilter = req.getParameter("name");
        String departmentIdParam = req.getParameter("departmentId");
        String startDateParam = req.getParameter("startDate");

        // Get all active doctors
        List<DoctorDTO> doctors = doctorService.findAll().stream()
                .filter(DoctorDTO::getActif) // Only active doctors
                .collect(Collectors.toList());

        System.out.println("=== PATIENT DOCTORS FILTER DEBUG ===");
        System.out.println("Total active doctors: " + doctors.size());
        System.out.println("Name filter: " + nameFilter);
        System.out.println("Department ID filter: " + departmentIdParam);
        System.out.println("Date filter: " + startDateParam);

        // Apply date filter first (if provided) - filter by doctors with availability
        LocalDate filterDate = null;
        if (startDateParam != null && !startDateParam.trim().isEmpty()) {
            try {
                filterDate = LocalDate.parse(startDateParam);
                System.out.println("Parsed date: " + filterDate + ", Day: " + filterDate.getDayOfWeek());
                List<Long> availableDoctorIds = availabilityRepository.findDoctorIdsWithAvailabilityOnDate(filterDate);
                System.out.println("Doctor IDs with availability on " + filterDate + ": " + availableDoctorIds);
                doctors = doctors.stream()
                        .filter(d -> availableDoctorIds.contains(d.getId()))
                        .collect(Collectors.toList());
                System.out.println("After date filter: " + doctors.size() + " doctors");
            } catch (DateTimeParseException e) {
                System.out.println("Invalid date format: " + e.getMessage());
            }
        }

        // Apply name filter
        if (nameFilter != null && !nameFilter.trim().isEmpty()) {
            String searchTerm = nameFilter.trim().toLowerCase();
            doctors = doctors.stream()
                    .filter(d -> d.getNom().toLowerCase().contains(searchTerm))
                    .collect(Collectors.toList());
            System.out.println("After name filter '" + searchTerm + "': " + doctors.size() + " doctors");
        }

        // Apply department filter
        if (departmentIdParam != null && !departmentIdParam.trim().isEmpty()) {
            try {
                Long deptId = Long.valueOf(departmentIdParam);
                doctors = doctors.stream()
                        .filter(d -> d.getDepartmentId() != null && d.getDepartmentId().equals(deptId))
                        .collect(Collectors.toList());
                System.out.println("After department filter (ID=" + deptId + "): " + doctors.size() + " doctors");
            } catch (NumberFormatException ignore) {
                System.out.println("Invalid department ID format");
            }
        }

        System.out.println("FINAL RESULT: " + doctors.size() + " doctors");
        System.out.println("====================================");

        req.setAttribute("doctors", doctors);
        req.setAttribute("nameFilter", nameFilter != null ? nameFilter : "");
        req.setAttribute("selectedDepartmentId", departmentIdParam != null ? departmentIdParam : "");
        req.setAttribute("startDate", startDateParam != null ? startDateParam : "");

        req.getRequestDispatcher("/WEB-INF/views/patient/doctors.jsp").forward(req, resp);
    }
}
