package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet pour gérer l'accès à la page de connexion.
 * Il redirige simplement l'utilisateur vers le fichier JSP de la page de connexion.
 */
@WebServlet("/landing") 
public class Landing extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Gère les requêtes GET pour afficher la page de connexion.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chemin vers votre fichier JSP de connexion.
        // Assurez-vous que le chemin est correct. 
        // Par convention, on le place dans /WEB-INF/ pour le protéger.
        String jspPath = "/WEB-INF/code_jsp/landing.jsp"; 

        // Utilisation de RequestDispatcher pour transférer la requête vers la page JSP.
        request.getRequestDispatcher(jspPath).forward(request, response);
    }
}