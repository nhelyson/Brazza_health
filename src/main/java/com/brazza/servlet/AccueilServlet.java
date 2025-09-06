package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/pagedeconnexion") // URL pour accéder à cette page
public class AccueilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ce code pointe directement vers landing.jsp sans vérifier la session.
        // Assurez-vous que le chemin est correct.
        request.getRequestDispatcher("/WEB-INF/code_jsp/landing.jsp").forward(request, response);
    }
}