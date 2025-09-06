<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Profil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .profile-card { max-width: 900px; margin: 2rem auto; background-color: #fff; border-radius: 15px; box-shadow: 0 6px 25px rgba(0,0,0,0.1); padding: 2rem; }
        .profile-card h3 { margin-bottom: 2rem; }
        .form-label { font-weight: bold; }
        .btn-save { background-color: #2575fc; color: #fff; }
        .btn-save:hover { background-color: #1354c8; color: #fff; }
        .profile-photo { width: 150px; height: 150px; object-fit: cover; border-radius: 50%; border: 3px solid #2575fc; margin-bottom: 1rem; }
        .photo-input { margin-top: 0.5rem; }
        hr { border-top: 1px solid #ddd; }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="profile-card">
    <h3>Mon Profil</h3>

    <c:if test="${not empty sessionScope.userId}">

        <!-- Affichage photo de profil -->
        <div class="text-center">
            <c:choose>
                <c:when test="${not empty sessionScope.userPhoto}">
                    <img src="${pageContext.request.contextPath}/${sessionScope.userPhoto}" class="profile-photo" alt="Photo de profil">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="profile-photo" alt="Photo par défaut">
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Formulaire pour modifier les infos et la photo -->
        <form action="${pageContext.request.contextPath}/ModifierProfil" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="photo" class="form-label">Changer la photo de profil</label>
                <input type="file" class="form-control photo-input" id="photo" name="photo" accept="image/*">
            </div>
            <div class="mb-3">
                <label for="prenom" class="form-label">Prénom</label>
                <input type="text" class="form-control" id="prenom" name="prenom" value="${sessionScope.userPrenom}" required>
            </div>
            <div class="mb-3">
                <label for="nom" class="form-label">Nom</label>
                <input type="text" class="form-control" id="nom" name="nom" value="${sessionScope.userNom}" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${sessionScope.userEmail}" required>
            </div>
            <button type="submit" class="btn btn-save">Enregistrer les modifications</button>
        </form>

        <hr class="my-4">

        <!-- Formulaire changement de mot de passe -->
        <h5>Changer le mot de passe</h5>
        <form action="${pageContext.request.contextPath}/ChangerMotDePasse" method="post">
            <div class="mb-3">
                <label for="ancienPwd" class="form-label">Mot de passe actuel</label>
                <input type="password" class="form-control" id="ancienPwd" name="ancienPwd" required>
            </div>
            <div class="mb-3">
                <label for="nouveauPwd" class="form-label">Nouveau mot de passe</label>
                <input type="password" class="form-control" id="nouveauPwd" name="nouveauPwd" required>
            </div>
            <div class="mb-3">
                <label for="confirmerPwd" class="form-label">Confirmer le nouveau mot de passe</label>
                <input type="password" class="form-control" id="confirmerPwd" name="confirmerPwd" required>
            </div>
            <button type="submit" class="btn btn-save">Changer le mot de passe</button>
        </form>
    </c:if>

    <c:if test="${empty sessionScope.userId}">
        <p class="text-danger">Vous devez être connecté pour accéder à votre profil.</p>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
