package org.example.Servlets;


import org.example.dto.SpecialityDTO;
import org.example.service.DepartmentService;
import org.example.service.SpecialityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/specialities/edit")
public class SpecialityEditServlet extends HttpServlet {
    @Inject
    private SpecialityService service;
    @Inject
    private DepartmentService departmentService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        req.setAttribute("id", id);
        req.setAttribute("dto", service.findById(id));
        req.setAttribute("departments", departmentService.findAll());
        req.getRequestDispatcher("/admin/specialityForm.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        SpecialityDTO dto = new SpecialityDTO();
        dto.setCode(req.getParameter("code"));
        dto.setNom(req.getParameter("nom"));
        dto.setDescription(req.getParameter("description"));
        dto.setDepartmentId(Long.valueOf(req.getParameter("departmentId")));
        try {
            service.update(id, dto);
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=spec-updated");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("id", id);
            req.setAttribute("dto", dto);
            req.setAttribute("departments", departmentService.findAll());
            doGet(req, resp);
        }
    }
}