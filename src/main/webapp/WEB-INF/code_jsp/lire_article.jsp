<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.brazza.model.ArticleBean"%>
<%@ page import="com.brazza.model.CommentaireBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de l'article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .main-article-card { background-color: #fff; border-radius:12px; box-shadow:0 4px 20px rgba(0,0,0,0.05); transition: transform 0.3s; }
        .main-article-card:hover { transform: translateY(-5px); }
        .sidebar-card { background-color: #fff; border-radius:12px; box-shadow:0 4px 20px rgba(0,0,0,0.05); }
        .article-image { max-width:100%; height:auto; border-radius:8px; margin-bottom:20px; }
        .recent-article-link { font-weight:500; color:#007bff; text-decoration:none; }
        .recent-article-link:hover { text-decoration:underline; }
        .comment-box { background:#fff; border-radius:8px; padding:15px; box-shadow:0 2px 8px rgba(0,0,0,0.05); }
        .comment { border-bottom:1px solid #eee; padding:10px 0; display:flex; gap:10px; }
        .comment:last-child { border-bottom:none; }
        .comment-img { width:50px; height:50px; border-radius:50%; object-fit:cover; }
        .comment-content { flex:1; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container mt-5">
    <div class="row g-4 align-items-start">
        <div class="col-lg-8">
            <div class="card main-article-card p-4">
                <%
                    ArticleBean article = (ArticleBean) request.getAttribute("article");
                    if(article != null){
                        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy 'à' HH:mm");
                %>
                <h1 class="card-title fw-bold mb-3"><%= article.getTitre() %></h1>
                <p class="text-muted">
                    <i class="fas fa-user-circle me-1"></i> Par <strong><%= article.getAuteur() %></strong>
                    <i class="fas fa-calendar-alt ms-3 me-1"></i> <%= sdf.format(article.getDatePublication()) %>
                </p>
                <hr class="my-4">
                <% if(article.getImagePrincipale()!=null && !article.getImagePrincipale().isEmpty()){ %>
                    <img src="<%= request.getContextPath() + "/" + article.getImagePrincipale() %>" alt="Image de l'article" class="article-image">
                <% } %>
                <div class="card-text lead" style="white-space: pre-wrap;"><%= article.getContenu() %></div>
                <div class="text-center mt-4">
                    <a href="<%= request.getContextPath() %>/Affiche_wiki" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-2"></i>Retour au wiki</a>
                </div>

                <!-- Formulaire commentaire -->
                <hr class="my-4">
                <h3 class="fw-bold">Laisser un commentaire</h3>
                <form action="<%= request.getContextPath() %>/CommentaireServlet" method="post" class="mb-4">
                    <input type="hidden" name="article_id" value="<%= article.getId() %>">
                    <div class="mb-3">
                        <textarea name="contenu" rows="4" class="form-control" placeholder="Votre commentaire..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane me-1"></i> Publier</button>
                </form>

                <!-- Commentaires -->
                <h3 class="fw-bold mb-3">Commentaires</h3>
                <div class="comment-box">
                    <%
                        List<CommentaireBean> commentaires = (List<CommentaireBean>) request.getAttribute("commentaires");
                        if(commentaires != null && !commentaires.isEmpty()){
                            for(CommentaireBean com : commentaires){
                    %>
                        <div class="comment">
                            <% if(com.getPhotoAuteur() != null && !com.getPhotoAuteur().isEmpty()){ %>
                                <img src="<%= request.getContextPath() + "/" + com.getPhotoAuteur() %>" alt="Photo de profil" class="comment-img">
                            <% } %>
                            <div class="comment-content">
                                <p class="mb-1">
                                    <strong><i class="fas fa-user"></i> <%= com.getAuteur() %></strong>
                                    <small class="text-muted">(<%= new SimpleDateFormat("dd/MM/yyyy HH:mm").format(com.getDateCommentaire()) %>)</small>
                                </p>
                                <p><%= com.getContenu() %></p>
                            </div>
                        </div>
                    <%
                            }
                        } else {
                    %>
                        <p class="text-muted">Aucun commentaire pour l’instant. Soyez le premier à réagir !</p>
                    <%
                        }
                    %>
                </div>

                <%
                    } else {
                %>
                <div class="alert alert-warning text-center">Article non trouvé.</div>
                <%
                    }
                %>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card sidebar-card p-4">
                <h5 class="fw-bold mb-3">Articles récents</h5>
                <ul class="list-unstyled">
                <%
                    List<ArticleBean> recentArticles = (List<ArticleBean>) request.getAttribute("recentArticles");
                    if(recentArticles != null && !recentArticles.isEmpty()) {
                        for(ArticleBean ra : recentArticles){
                %>
                    <li class="mb-3 border-bottom pb-2">
                        <a href="<%= request.getContextPath() %>/LireArticle?id=<%= ra.getId() %>" class="recent-article-link"><%= ra.getTitre() %></a>
                        <small class="d-block text-muted mt-1">
                            <i class="fas fa-clock me-1"></i><%= new SimpleDateFormat("dd/MM/yyyy").format(ra.getDatePublication()) %>
                        </small>
                    </li>
                <%
                        }
                    } else {
                %>
                    <li class="text-muted">Aucun autre article pour le moment.</li>
                <%
                    }
                %>
                </ul>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
