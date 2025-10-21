package org.example.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Inject
    private org.example.service.UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        boolean remember = req.getParameter("remember") != null;

        try {
            org.example.entities.User user = userService.authenticate(email, password);

            HttpSession session = req.getSession();
            session.setAttribute("authUser", user);
            session.setAttribute("userRole", user.getRole().name());

            if (remember) {
                Cookie c = new Cookie("remember", user.getId() + ":" + UUID.randomUUID());
                c.setMaxAge(30 * 24 * 60 * 60);
                c.setPath("/");
                c.setHttpOnly(true);
                resp.addCookie(c);
            }

            String target = req.getContextPath() + "/" + user.getRole().name().toLowerCase() + "/dashboard";
            resp.sendRedirect(target);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}