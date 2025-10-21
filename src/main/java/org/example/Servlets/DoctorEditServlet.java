package org.example.Servlets;

import org.example.dto.DoctorDTO;
import org.example.service.DoctorService;
import org.example.service.SpecialityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/doctors/edit")
public class DoctorEditServlet extends HttpServlet {
    
    @Inject
    private DoctorService doctorService;
    
    @Inject
    private SpecialityService specialityService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?error=missing-id");
            return;
        }

        try {
            Long id = Long.valueOf(idParam);
            DoctorDTO doctor = doctorService.findById(id);
            
            if (doctor == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/doctors?error=doctor-not-found");
                return;
            }

            // Passer les données au JSP
            req.setAttribute("dto", doctor);
            req.setAttribute("specialities", specialityService.findAll());
            req.setAttribute("isEdit", true);
            
            req.getRequestDispatcher("/admin/doctorForm.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?error=invalid-id");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?error=server-error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?error=missing-id");
            return;
        }

        try {
            Long id = Long.valueOf(idParam);
            
            DoctorDTO dto = new DoctorDTO();
            dto.setId(id);
            dto.setNom(req.getParameter("nom"));
            dto.setEmail(req.getParameter("email"));
            dto.setMatricule(req.getParameter("matricule"));
            dto.setTitre(req.getParameter("titre"));
            dto.setSpecialtyId(Long.valueOf(req.getParameter("specialtyId")));
            
            String actifParam = req.getParameter("actif");
            dto.setActif(actifParam != null && actifParam.equals("true"));
            
            doctorService.update(id, dto);
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?msg=doc-updated");
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/doctors?error=invalid-data");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}
