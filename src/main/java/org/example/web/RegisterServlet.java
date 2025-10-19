package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dto.PatientDTO;
import org.example.entities.Patient;
import org.example.entities.enums.Gender;
import org.example.service.PatientService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Inject
    PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("genders", Gender.values());
        req.getRequestDispatcher("/WEB-INF/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        PatientDTO dto = new PatientDTO();
        dto.setNom(req.getParameter("nom"));
        dto.setEmail(req.getParameter("email"));
        dto.setPassword(req.getParameter("password"));
        dto.setCin(req.getParameter("cin"));
        dto.setDateNaissance(LocalDate.parse(req.getParameter("dateNaissance")));
        dto.setSexe(Gender.valueOf(req.getParameter("sexe")));

        try {
            Patient patient = patientService.register(dto);
            req.getSession().setAttribute("authUser", patient);
            req.getSession().setAttribute("userRole", patient.getRole().name());
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("dto", dto);
            doGet(req, resp);
        }
    }
}