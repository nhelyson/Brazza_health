package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/wiki") // URL que l’utilisateur tape
public class Wikiservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // ne crée pas de session
        if (session != null && session.getAttribute("userId") != null) {
            // Utilisateur connecté → forward vers wiki.jsp
            request.getRequestDispatcher("/WEB-INF/code_jsp/wiki.jsp").forward(request, response);
        } else {
            // Pas connecté → forward vers connexion.jsp (URL reste la même)
            request.getRequestDispatcher("/WEB-INF/code_jsp/connexion.jsp").forward(request, response);
        }
    }
}
