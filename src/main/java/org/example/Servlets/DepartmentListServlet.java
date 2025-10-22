package org.example.Servlets;

import org.example.service.DepartmentService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/departments")
public class DepartmentListServlet extends HttpServlet {
    @Inject
    private DepartmentService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("departments", service.findAll());
        req.getRequestDispatcher("/admin/departmentList.jsp").forward(req, resp);
    }
}
