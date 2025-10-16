package org.example.Servlets;

import org.example.service.DoctorService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/doctors")
public class DoctorListServlet extends HttpServlet {
    @Inject
    private DoctorService service;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("doctors", service.findAll());
        req.getRequestDispatcher("/admin/doctorList.jsp").forward(req, resp);
    }
}