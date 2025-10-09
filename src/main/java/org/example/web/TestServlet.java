package org.example.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "TestServlet", urlPatterns = {"/test", "/test.do"})
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Page</title>");
        out.println("<style>");
        out.println("body { font-family: Arial; margin: 50px; background: #f0f0f0; }");
        out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }");
        out.println("h1 { color: #28a745; }");
        out.println("a { color: #007bff; text-decoration: none; font-size: 18px; }");
        out.println("a:hover { text-decoration: underline; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h1>✅ Application is Working!</h1>");
        out.println("<p>✅ Tomcat: <strong>Running</strong></p>");
        out.println("<p>✅ Servlet: <strong>Working</strong></p>");
        out.println("<p>📅 Time: " + new java.util.Date() + "</p>");
        out.println("<hr>");
        out.println("<p><a href='db-test'>🔍 Test Database Connection →</a></p>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}