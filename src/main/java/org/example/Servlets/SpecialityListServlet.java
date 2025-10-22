package org.example.Servlets;

import org.example.service.SpecialityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/specialities")
public class SpecialityListServlet extends HttpServlet {
    @Inject
    private SpecialityService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("specialities", service.findAll());
        req.getRequestDispatcher("/admin/specialityList.jsp").forward(req, resp);
    }
}
