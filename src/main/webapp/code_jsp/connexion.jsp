<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Brazza Sani - Connexion</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/code_css/styleconnect.css">
</head>
<body>
    <div class="main-wrapper">
        <div class="top-left-logo">
            <div class="dot">♻️</div> <span>Brazza heatlth</span>
        </div>

        <div class="top-right-icons">
            <div class="icon-circle"><i class="fa-solid fa-trash-can"></i></div>
            <div class="icon-circle"><i class="fa-solid fa-seedling"></i></div>
        </div>

        <div class="login-box">
            <h3 style="font-size:2rem;">pour une ville plus propre</h3>
            <p>Connectez-vous pour rejoindre notre initiative d'assainissement.</p>

            <form action="<%= request.getContextPath() %>/loginServlet" method="post">
                <div class="input-group">
                    <span class="icon"><i class="fa-solid fa-envelope"></i></span>
                    <input type="text" name="identifiant" placeholder="Votre Email ou Nom d'utilisateur" required>
                </div>
                <div class="input-group">
                    <span class="icon"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" name="motdepasse" placeholder="Votre mot de passe" required>
                </div>
                <button type="submit" class="btn btn-primary">Se connecter</button>
            </form>

            <div class="login-link">
                Pas encore de compte ? <a href="forminscription.jsp">S'inscrire</a>
            </div>
        </div>

       
        <div class="illustration-block1">
        </div>
        <div class="illustration-arrow"></div>

        <div class="illustration-block2"></div>
        <div class="illustration-cloud"></div>
    </div>
</body>
</html>