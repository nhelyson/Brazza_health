<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalider la session
    if (session != null) {
        session.invalidate();
    }

    // Rediriger vers le formulaire d'inscription
    response.sendRedirect("connexion.jsp");
%>
