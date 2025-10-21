package org.example.web;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import org.example.entities.User;
import org.example.entities.enums.Role;

import java.io.IOException;

@WebFilter({"/admin/*", "/org/example/Servlets/doctor/*", "/patient/*", "/staff/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        User user = (User) req.getSession().getAttribute("authUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getRequestURI();
        String rolePrefix = "/" + user.getRole().name().toLowerCase() + "/";
        boolean isAdmin = user.getRole() == Role.ADMIN;

        if (!isAdmin && !path.contains(rolePrefix)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès interdit");
            return;
        }

        chain.doFilter(request, response);
    }
}