<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalider la session si elle existe
    if (session != null) {
        session.invalidate();
    }

    // Rediriger vers la page d'inscription/connexion
    response.sendRedirect(request.getContextPath() + "/landing");
%>
