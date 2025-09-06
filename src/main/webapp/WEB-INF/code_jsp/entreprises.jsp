<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.brazza.servlet.Entreprise.Societe" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sociétés d'Assainissement à Brazzaville</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Poppins', sans-serif;
        }

        h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-weight: 700;
            color: #343a40;
        }

        /* Barre de recherche */
        #search-bar {
            max-width: 500px;
            margin: 0 auto 5rem auto; /* plus d'espace en bas */
        }

        /* Conteneur des cartes */
        #societeContainer {
            margin-top: 2rem; /* espace supplémentaire si besoin */
        }

        /* Cartes sociétés */
        .societe-card {
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: #fff;
            margin-bottom: 2rem;
        }
        .societe-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        .societe-card-body {
            padding: 1.8rem;
        }
        .societe-card-body h5 {
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 0.8rem;
        }
        .societe-card-body p {
            margin-bottom: 0.6rem;
            line-height: 1.4;
        }
        .societe-link {
            text-decoration: none;
            color: #0d6efd;
        }
        .societe-link:hover {
            text-decoration: underline;
        }
        .icon {
            margin-right: 0.5rem;
            color: #0d6efd;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container mt-5">
    <h1>Sociétés d'Assainissement à Brazzaville</h1>

    <!-- Barre de recherche -->
    <div id="search-bar" class="input-group mb-4">
        <input type="text" id="searchInput" class="form-control" placeholder="Rechercher une société...">
        <span class="input-group-text"><i class="fa-solid fa-magnifying-glass"></i></span>
    </div>

    <!-- Conteneur des cartes -->
    <div class="row mt-5 p-3" id="societeContainer">
        <%
            List<Societe> societes = (List<Societe>) request.getAttribute("societes");
            if (societes != null && !societes.isEmpty()) {
                for (Societe societe : societes) {
        %>
        <div class="col-md-6 col-lg-4 societe-item">
            <div class="societe-card">
                <div class="societe-card-body">
                    <h5><i class="fa-solid fa-building icon"></i> <%= societe.getNom() %></h5>
                    <p><strong>Description:</strong> <%= societe.getDescription() %></p>
                    <p><i class="fa-solid fa-location-dot icon"></i> <strong>Adresse:</strong> <%= societe.getAdresse() %></p>
                    <p><i class="fa-solid fa-phone icon"></i> <strong>Téléphone:</strong> 
                        <%= societe.getTelephone() %>
                    </p>
                    <p><i class="fa-solid fa-envelope icon"></i> <strong>Email:</strong> 
                        <a class="societe-link" href="mailto:<%= societe.getEmail() %>"><%= societe.getEmail() %></a>
                    </p>
                    <p><i class="fa-solid fa-globe icon"></i> <strong>Site Web:</strong> 
                        <a class="societe-link" href="<%= societe.getSiteWeb() %>" target="_blank">Visiter</a>
                    </p>
                    <p><i class="fa-solid fa-map-location-dot icon"></i> <strong>Localisation:</strong> 
                        <a class="societe-link" href="<%= societe.getLienMaps() %>" target="_blank">Voir sur Google Maps</a>
                    </p>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="col-12 text-center text-muted">
            <p>Aucune société d'assainissement n'est disponible pour le moment.</p>
        </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Filtrage dynamique des sociétés par recherche
    const searchInput = document.getElementById('searchInput');
    const societeContainer = document.getElementById('societeContainer');
    const items = societeContainer.getElementsByClassName('societe-item');

    searchInput.addEventListener('keyup', function() {
        const filter = searchInput.value.toLowerCase();
        for (let i = 0; i < items.length; i++) {
            const text = items[i].textContent.toLowerCase();
            items[i].style.display = text.includes(filter) ? "" : "none";
        }
    });
</script>
</body>
</html>
