package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register_connexion") // URL pour accéder à la page de connexion
public class register_connexion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirige directement vers la page de connexion, sans vérification de session
        request.getRequestDispatcher("/WEB-INF/code_jsp/connexion.jsp").forward(request, response);
    }
}