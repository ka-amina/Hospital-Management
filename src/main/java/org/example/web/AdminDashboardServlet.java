package org.example.web;

import org.example.service.DepartmentService;
import org.example.service.SpecialityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Inject
    private DepartmentService departmentService;
    @Inject
    private SpecialityService specialityService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("departments", departmentService.findAll());
        req.setAttribute("specialities", specialityService.findAll());
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}