<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 800px;
            margin-top: 50px;
            margin-bottom: 50px;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container d-flex justify-content-center">
        <div class="form-container">
            <h2 class="text-center mb-4">Montre nous les dechets de brazzaville</h2>
            <form action="<%= request.getContextPath() %>/creerArticleServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="titre" class="form-label">Titre de l'article</label>
                    <input type="text" class="form-control" id="titre" name="titre" required>
                </div>
                <div class="mb-3">
                    <label for="contenu" class="form-label">Contenu de l'article</label>
                    <textarea class="form-control" id="contenu" name="contenu" rows="8" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="photos" class="form-label">Photos (optionnel)</label>
                    <input type="file" class="form-control" id="photos" name="photos" multiple accept="image/*">
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">Publier l'article</button>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>