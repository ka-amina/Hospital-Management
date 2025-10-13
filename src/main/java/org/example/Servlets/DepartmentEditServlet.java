package org.example.Servlets;

import org.example.dto.DepartmentDTO;
import org.example.service.DepartmentService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/departments/edit")
public class DepartmentEditServlet extends HttpServlet {
    @Inject
    private DepartmentService service;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        req.setAttribute("id", id);
        req.setAttribute("dto", service.findById(id));
        req.getRequestDispatcher("/admin/departmentForm.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        DepartmentDTO dto = new DepartmentDTO();
        dto.setCode(req.getParameter("code"));
        dto.setNom(req.getParameter("nom"));
        dto.setDescription(req.getParameter("description"));
        try {
            service.update(id, dto);
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=dept-updated");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("id", id);
            req.setAttribute("dto", dto);
            doGet(req, resp);
        }
    }
}