<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wiki Brazza Sani</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .wiki-card { box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24); border-radius: 8px; margin-bottom: 2rem; }
        .wiki-card-header { display: flex; align-items: center; padding: 1rem 1.25rem; border-bottom: 1px solid #dee2e6; }
        .wiki-card-header img { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; margin-right: 15px; }
        .wiki-card-body { padding: 0; }
        .wiki-card-image { width: 100%; height: auto; max-height: 500px; object-fit: cover; }
        .wiki-card-content { padding: 1.25rem; }
        .jumbotron { background-color: #e9ecef; padding: 4rem 2rem; margin-bottom: 2rem; border-radius: .3rem; text-align: center; }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container mt-5">
        <div class="jumbotron">
            <h1 class="display-4">Le Wiki de Brazza Sani</h1>
            <p class="lead">Partagez des photos et des articles sur l'assainissement de Brazzaville.</p>
            <hr class="my-4">
            <a class="btn btn-primary btn-lg" href="article.jsp">
                <i class="fa-solid fa-plus-circle me-2"></i> Publier un article
            </a>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <c:forEach var="article" items="${articles}">
                    <div class="card wiki-card">
                        <div class="wiki-card-header">
                            <img src="https://via.placeholder.com/50" alt="Photo de profil">
                            <div>
                                <h6 class="mb-0 fw-bold"><c:out value="${article.auteur}" /></h6>
                                <small class="text-muted"><c:out value="${article.datePublication}" /></small>
                            </div>
                        </div>
                        <div class="wiki-card-body">
                            <c:if test="${not empty article.imagePrincipale}">
                                <img src="${article.imagePrincipale}" class="wiki-card-image img-fluid rounded" alt="Image de l'article : ${article.titre}">
                            </c:if>
                            <div class="wiki-card-content">
                                <h5 class="card-title"><c:out value="${article.titre}" /></h5>
                                <p class="card-text">
                                    <c:choose>
                                        <c:when test="${fn:length(article.contenu) > 250}">
                                            <c:out value="${fn:substring(article.contenu, 0, 250)}" />...
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${article.contenu}" />
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-0 text-center">
                            <a href="${pageContext.request.contextPath}/article?id=${article.id}" class="btn btn-outline-primary w-100">
                                <i class="fa-solid fa-comment me-2"></i> Lire l'article et commenter
                            </a>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty articles}">
                    <div class="col-12 text-center">
                        <p class="text-muted">Aucun article n'a été publié pour le moment. Soyez le premier à contribuer !</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
