<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <i class="fa-solid fa-hand-holding-droplet me-2 text-info"></i>
      <span class="fw-bold">Brazza heatlth</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link text-white-50 active" aria-current="page" href="${pageContext.request.contextPath}/Acceuil">Accueil</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/Entreprise">Entreprises</a>
        </li>
        
        <li class="nav-item">
            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/Affiche_wiki">Wiki</a>
        </li>
        
        <%-- JSTL condition to show Admin link --%>
        <c:if test="${sessionScope.userRole eq 'admin'}">
            <li class="nav-item">
                <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/AdminInterface">Admin</a>
            </li>
        </c:if>
        
        <c:if test="${sessionScope.userEmail != null}">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-white-50" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Mon Compte
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/CompteUtilisateur">Profil</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mesArticles">Mes Articles</a></li>
                    <li><hr class="dropdown-divider"></li>
                </ul>
            </li>
        </c:if>
        
        <c:if test="${sessionScope.userEmail != null}">
            <li class="nav-item">
                <a class="btn btn-warning ms-lg-3 fw-bold" href="${pageContext.request.contextPath}/deconnexion">Déconnexion</a>
            </li>
        </c:if>
        
      </ul>
    </div>
  </div>
</nav>