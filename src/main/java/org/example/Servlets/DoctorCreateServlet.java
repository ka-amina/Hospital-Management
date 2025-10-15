package org.example.Servlets;

import org.example.dto.DoctorDTO;
import org.example.service.DoctorService;
import org.example.service.SpecialityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/doctors/new")
public class DoctorCreateServlet extends HttpServlet {
    @Inject
    private DoctorService doctorService;
    @Inject
    private SpecialityService specialityService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("specialities", specialityService.findAll());
        req.setAttribute("dto", new DoctorDTO());
        req.getRequestDispatcher("/admin/doctorForm.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        DoctorDTO dto = new DoctorDTO();
        dto.setNom(req.getParameter("nom"));
        dto.setEmail(req.getParameter("email"));
        dto.setMatricule(req.getParameter("matricule"));
        dto.setTitre(req.getParameter("titre"));
        dto.setSpecialtyId(Long.valueOf(req.getParameter("specialtyId")));
        dto.setActif(Boolean.valueOf(req.getParameter("actif")));
        try {
            doctorService.create(dto);
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?msg=doc-created");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}