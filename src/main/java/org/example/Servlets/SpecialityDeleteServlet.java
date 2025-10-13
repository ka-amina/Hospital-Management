package org.example.Servlets;


import org.example.service.SpecialityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/specialities/delete")
public class SpecialityDeleteServlet extends HttpServlet {
    @Inject
    private SpecialityService service;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        service.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard?msg=spec-deleted");
    }
}