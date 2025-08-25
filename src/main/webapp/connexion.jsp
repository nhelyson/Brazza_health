<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Thème Nature</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <!-- AOS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css"/>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="styleconnect.css">
</head>
<body id="body_connect">
<div class="container form-container">
    <div class="card w-100" style="max-width: 500px;" data-aos="fade-up">
        <h2 class="text-center form-title mb-4 animate__animated animate__fadeInDown"><i class="fa-solid fa-leaf me-2"></i>Connexion</h2>

        <%-- Message d'erreur si besoin --%>
        <%
            String error = request.getParameter("error");
            if ("invalid".equals(error)) {
        %>
            <div class="alert alert-danger">Identifiant ou mot de passe incorrect.</div>
        <% } else if ("exception".equals(error)) { %>
            <div class="alert alert-danger">Une erreur est survenue, veuillez réessayer.</div>
        <% } %>

        <form action="<%= request.getContextPath() %>/loginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Nom d'utilisateur ou Email</label>
                <input type="text" id="loginInput" name="identifiant" class="form-control" placeholder="Nom d'utilisateur ou email" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mot de passe</label>
                <input type="password" name="motdepasse" class="form-control" placeholder="Votre mot de passe" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 btn-lg">Se connecter</button>
        </form>

        <p class="text-center mt-3">Pas encore de compte ?
            <a href="forminscription.jsp">S'inscrire</a>
        </p>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    AOS.init({
        duration: 1000,
        once: true
    });
</script>
<script src="globale_auth.js"></script>
</body>
</html>
