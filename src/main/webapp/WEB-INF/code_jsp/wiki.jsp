<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.brazza.model.ArticleBean" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Wiki Brazza Sani</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .jumbotron {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 3rem 2rem;
            margin-bottom: 2rem;
            border-radius: 0.5rem;
            text-align: center;
        }
        .jumbotron a.btn {
            background-color: #ff9800;
            border: none;
            font-weight: bold;
            transition: 0.3s;
        }
        .jumbotron a.btn:hover { background-color: #e68a00; }

        /* GRID et cards */
        .articles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }
        .article-link {
            text-decoration: none; /* Retire le soulignement du lien */
            color: inherit; /* Utilise la couleur du texte parent */
            height: 100%;
        }
        .article-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            background-color: #fff;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .article-link:hover .article-card {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .article-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .article-link:hover .article-card img { transform: scale(1.05); }
        .article-card-body {
            padding: 1rem;
            flex-grow: 1;
        }
        .article-card-body h5 {
            font-weight: bold;
            min-height: 3rem;
        }
        .article-card-body p {
            font-size: 0.95rem;
            line-height: 1.4;
            color: #555;
        }
        .article-card-footer {
            background-color: #f8f9fa;
            padding: 0.5rem 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container mt-5">
    <div class="jumbotron">
        <h1 class="display-4">Bienvenue sur notre wiki</h1>
        <p class="lead">Partagez vos articles et images sur l'assainissement de Brazzaville.</p>
        <a class="btn btn-lg" href="<%= request.getContextPath() %>/postArticle">
            <i class="fa-solid fa-plus-circle me-2"></i> Publier un article
        </a>
    </div>

    <div class="articles-grid">
        <%
            List<ArticleBean> articles = (List<ArticleBean>) request.getAttribute("articles");
            if (articles != null && !articles.isEmpty()) {
                for (ArticleBean article : articles) {
        %>
            <a href="<%= request.getContextPath() %>/LireArticle?id=<%= article.getId() %>" class="article-link">
                <div class="article-card">
                    <% if (article.getImagePrincipale() != null && !article.getImagePrincipale().isEmpty()) { %>
                        <img src="<%= request.getContextPath() + "/" + article.getImagePrincipale() %>" alt="Image de l'article">
                    <% } %>
                    <div class="article-card-body">
                        <h5><%= article.getTitre() %></h5>
                        <p>
                            <%
                                String contenu = article.getContenu();
                                int maxLength = 120;
                                if (contenu.length() > maxLength) {
                                    out.print(contenu.substring(0, maxLength) + "...");
                                } else {
                                    out.print(contenu);
                                }
                            %>
                        </p>
                    </div>
                    <div class="article-card-footer">
                        <span>Par <%= article.getAuteur() %></span>
                    </div>
                </div>
            </a>
        <%
                }
            } else {
        %>
            <div class="col-12 text-center text-muted">
                <p>Aucun article publié pour le moment. Soyez le premier à contribuer !</p>
            </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>