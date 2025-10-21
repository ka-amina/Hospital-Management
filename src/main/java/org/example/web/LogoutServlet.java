package org.example.web;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();

        Cookie c = new Cookie("remember", "");
        c.setMaxAge(0);
        c.setPath("/");
        resp.addCookie(c);

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}