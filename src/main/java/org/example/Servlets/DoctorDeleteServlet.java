package org.example.Servlets;

import org.example.service.DoctorService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/doctors/delete")
public class DoctorDeleteServlet extends HttpServlet {
    @Inject
    private DoctorService doctorService;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        doctorService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/doctors?msg=doc-deleted");
    }
}