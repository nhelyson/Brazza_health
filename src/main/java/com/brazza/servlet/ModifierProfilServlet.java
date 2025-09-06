package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/ModifierProfil")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024,   // 5 MB
        maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class ModifierProfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    // Dossier pour stocker les photos (chemin relatif au projet)
    private final String UPLOAD_DIR = "uploads/photos";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");

        // Gestion du fichier uploadé
        Part photoPart = request.getPart("photo");
        String photoFileName = null;

        if (photoPart != null && photoPart.getSize() > 0) {
            // Récupérer le nom du fichier
            photoFileName = Paths.get(photoPart.getSubmittedFileName()).getFileName().toString();

            // Créer le dossier si nécessaire
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Enregistrer le fichier
            photoPart.write(uploadPath + File.separator + photoFileName);
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {
                String sql;
                if (photoFileName != null) {
                    // Mettre à jour les infos + photo
                    sql = "UPDATE utilisateurs SET nom = ?, prenom = ?, email = ?, photo = ? WHERE id = ?";
                } else {
                    // Mettre à jour uniquement les infos
                    sql = "UPDATE utilisateurs SET nom = ?, prenom = ?, email = ? WHERE id = ?";
                }

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, nom);
                    stmt.setString(2, prenom);
                    stmt.setString(3, email);
                    if (photoFileName != null) {
                        stmt.setString(4, UPLOAD_DIR + "/" + photoFileName);
                        stmt.setInt(5, userId);
                    } else {
                        stmt.setInt(4, userId);
                    }
                    stmt.executeUpdate();
                }
            }

            // Mettre à jour les informations dans la session
            session.setAttribute("userNom", nom);
            session.setAttribute("userPrenom", prenom);
            session.setAttribute("userEmail", email);
            if (photoFileName != null) {
                session.setAttribute("userPhoto", UPLOAD_DIR + "/" + photoFileName);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/CompteUtilisateur");
    }
}
