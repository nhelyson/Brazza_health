<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Créer un article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container-form {
            max-width: 700px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .form-control, .form-control:focus {
            border-radius: 8px;
            box-shadow: none;
        }

        .btn-submit {
            background-color: #ff6f00;
            color: #fff;
            font-weight: bold;
            border-radius: 8px;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background-color: #e56300;
        }

        .form-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-header h2 {
            font-weight: 700;
            color: #333;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container-form">
    <div class="form-header">
        <h2>Publier un nouvel article</h2>
        <p>Partagez vos informations sur l'assainissement</p>
    </div>

    <% if(request.getAttribute("error") != null) { %>
        <div class="error-message">
            <% String error = (String) request.getAttribute("error"); %>
            <% if("invalid_data".equals(error)) { %>
                Veuillez remplir le titre et le contenu.
            <% } else if("upload_failed".equals(error)) { %>
                Erreur lors du téléchargement de l'image.
            <% } else if("database_error".equals(error)) { %>
                Une erreur est survenue. Réessayez plus tard.
            <% } else if("not_authenticated".equals(error)) { %>
                Vous devez être connecté pour poster un article.
            <% } %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/creerArticleServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="titre" class="form-label">Titre de l'article</label>
            <input type="text" class="form-control" id="titre" name="titre" placeholder="Titre" required>
        </div>
        <div class="mb-3">
            <label for="contenu" class="form-label">Contenu</label>
            <textarea class="form-control" id="contenu" name="contenu" rows="6" placeholder="Votre texte..." required></textarea>
        </div>
        <div class="mb-3">
            <label for="photos" class="form-label">Ajouter des images (facultatif)</label>
            <input class="form-control" type="file" id="photos" name="photos" accept="image/*" multiple>
        </div>
        <button type="submit" class="btn btn-submit w-100"><i class="fa-solid fa-paper-plane me-2"></i>Publier</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
