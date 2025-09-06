package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deconnexion")
public class Downsession extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Redirige la requête vers la page down_session.jsp
        // Le chemin est relatif à la racine de l'application web.
        // Assurez-vous que le fichier down_session.jsp est dans le bon dossier.
        request.getRequestDispatcher("/WEB-INF/code_jsp/down.jsp").forward(request, response);
    }
}