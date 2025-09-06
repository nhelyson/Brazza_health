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
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/creerArticleServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class creerArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    // Dossier où seront stockées les images
    private static final String UPLOAD_DIRECTORY = "image_article";
    private String uploadPath;

    @Override
    public void init() throws ServletException {
        // Chemin complet du dossier dans le projet
        uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // crée le dossier si inexistant
            System.out.println("Dossier créé : " + uploadPath);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = null;
        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
        }

        if (userId == null) {
            request.setAttribute("error", "not_authenticated");
            request.getRequestDispatcher("/WEB-INF/connexion.jsp").forward(request, response);
            return;
        }

        String titre = request.getParameter("titre");
        String contenu = request.getParameter("contenu");
        List<String> photoPaths = new ArrayList<>();
        List<Path> uploadedFiles = new ArrayList<>();

        if (titre == null || titre.trim().isEmpty() || contenu == null || contenu.trim().isEmpty()) {
            request.setAttribute("error", "invalid_data");
            request.getRequestDispatcher("/WEB-INF/creer_article.jsp").forward(request, response);
            return;
        }

        try {
            for (Part part : request.getParts()) {
                if (part.getName().equals("photos") && part.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + "_" + part.getSubmittedFileName();
                    Path filePath = new File(uploadPath, fileName).toPath();
                    part.write(filePath.toString());

                    // Stocke uniquement le chemin relatif pour la base de données
                    photoPaths.add(UPLOAD_DIRECTORY + "/" + fileName);
                    uploadedFiles.add(filePath);
                }
            }
        } catch (Exception ex) {
            for (Path file : uploadedFiles) {
                try {
                    Files.deleteIfExists(file);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            request.setAttribute("error", "upload_failed");
            request.getRequestDispatcher("/WEB-INF/creer_article.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {
            conn.setAutoCommit(false);

            int articleId = 0;
            String insertArticleSQL = "INSERT INTO articles (titre, contenu, utilisateur_id) VALUES (?, ?, ?)";
            try (PreparedStatement stmtArticle = conn.prepareStatement(insertArticleSQL, Statement.RETURN_GENERATED_KEYS)) {
                stmtArticle.setString(1, titre);
                stmtArticle.setString(2, contenu);
                stmtArticle.setInt(3, userId);
                stmtArticle.executeUpdate();

                ResultSet generatedKeys = stmtArticle.getGeneratedKeys();
                if (generatedKeys.next()) {
                    articleId = generatedKeys.getInt(1);
                } else {
                    throw new Exception("Échec de l'obtention de l'ID de l'article.");
                }
            }

            String insertImageSQL = "INSERT INTO images (chemin, nom_fichier, article_id) VALUES (?, ?, ?)";
            try (PreparedStatement stmtImage = conn.prepareStatement(insertImageSQL)) {
                for (String path : photoPaths) {
                    String fileName = path.substring(path.lastIndexOf("/") + 1);
                    stmtImage.setString(1, path);
                    stmtImage.setString(2, fileName);
                    stmtImage.setInt(3, articleId);
                    stmtImage.addBatch();
                }
                stmtImage.executeBatch();
            }

            conn.commit();
            response.sendRedirect(request.getContextPath() + "/Affiche_wiki");

        } catch (Exception e) {
            e.printStackTrace();
            for (Path file : uploadedFiles) {
                try {
                    Files.deleteIfExists(file);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
            request.setAttribute("error", "database_error");
            request.getRequestDispatcher("/WEB-INF/code_jsp/post_article.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/post_article.jsp");
    }
}
