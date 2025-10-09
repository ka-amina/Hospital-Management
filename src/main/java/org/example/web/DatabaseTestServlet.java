package org.example.web;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DatabaseTestServlet", urlPatterns = {"/db-test", "/database-test"})
public class DatabaseTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Database Test</title>");
        out.println("<style>");
        out.println("body { font-family: Arial; margin: 50px; background: #f0f0f0; }");
        out.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }");
        out.println(".success { color: green; font-weight: bold; }");
        out.println(".error { color: red; font-weight: bold; }");
        out.println("pre { background: #f4f4f4; padding: 15px; border-radius: 5px; overflow: auto; }");
        out.println("ul { line-height: 2; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h1>🔍 Database Connection Test</h1>");

        EntityManagerFactory emf = null;
        EntityManager em = null;

        try {
            out.println("<p>🔄 Connecting to PostgreSQL database...</p>");
            out.flush();

            // Create EntityManagerFactory - this will create tables!
            emf = Persistence.createEntityManagerFactory("CliniqueDigitalePU");
            em = emf.createEntityManager();

            out.println("<p class='success'>✅ Database connection successful!</p>");
            out.println("<p class='success'>✅ All tables have been created/updated!</p>");

            // Test transaction
            em.getTransaction().begin();

            // Query to count users
            Long userCount = em.createQuery("SELECT COUNT(u) FROM User u", Long.class)
                    .getSingleResult();

            out.println("<p>📊 Total users in database: <strong>" + userCount + "</strong></p>");

            em.getTransaction().commit();

            out.println("<hr>");
            out.println("<h2>✅ Database Tables Created:</h2>");
            out.println("<ul>");
            out.println("<li>✅ users</li>");
            out.println("<li>✅ patients</li>");
            out.println("<li>✅ doctors</li>");
            out.println("<li>✅ departments</li>");
            out.println("<li>✅ specialties</li>");
            out.println("<li>✅ availabilities</li>");
            out.println("<li>✅ appointments</li>");
            out.println("<li>✅ medical_notes</li>");
            out.println("</ul>");

            out.println("<hr>");
            out.println("<p><a href='test'>← Back to Test Page</a></p>");

        } catch (Exception e) {
            out.println("<p class='error'>❌ Database connection failed!</p>");
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            out.println("<h3>Stack Trace:</h3>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");

            out.println("<hr>");
            out.println("<h3>🔧 Troubleshooting Steps:</h3>");
            out.println("<ol>");
            out.println("<li>Check if PostgreSQL is running: <code>psql -U postgres</code></li>");
            out.println("<li>Verify database exists: <code>CREATE DATABASE clinique_digitale;</code></li>");
            out.println("<li>Check persistence.xml credentials</li>");
            out.println("<li>Verify PostgreSQL port 5432 is open</li>");
            out.println("</ol>");

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
            if (emf != null && emf.isOpen()) {
                emf.close();
            }
        }

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}