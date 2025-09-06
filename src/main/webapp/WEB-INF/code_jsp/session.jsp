<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%
    // ==========================
    // Sécurité : Empêcher la mise en cache
    // ==========================
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // ==========================
    // Vérification de la session
    // ==========================
    HttpSession sessionUser = request.getSession(false); // ne crée pas de session si inexistante

    if (sessionUser == null || sessionUser.getAttribute("userEmail") == null) {
        // Redirection vers la page de login si l'utilisateur n'est pas connecté
        String loginURL = request.getContextPath() + "/login"; 
        response.sendRedirect(loginURL);
        return; // arrêter l'exécution du JSP
    }
%>
