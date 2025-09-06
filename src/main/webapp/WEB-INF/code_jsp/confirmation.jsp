<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String nom = (String) session.getAttribute("userNom");
    String email = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("userRole");

    if (nom == null || email == null || !"admin".equals(role)) {
        response.sendRedirect("connexion.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Panneau d'administration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #fdfbfb, #ebedee);
            min-height: 100vh;
            margin: 0;
        }
        .header {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            padding: 2rem 1rem;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .dashboard-container {
            max-width: 1100px;
            margin: -2rem auto 2rem;
            padding: 0 1rem;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.25);
        }
        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: #343a40;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Panneau d’administration 🛠️</h1>
    <p>Bienvenue <strong><%= nom %></strong> | Email : <%= email %></p>
</div>

<div class="dashboard-container">
    <div class="row g-4">
        <!-- Gestion des utilisateurs -->
        <div class="col-md-4">
            <div class="card text-center p-4">
                <i class="fas fa-users-cog card-icon"></i>
                <h5 class="card-title">Gestion des utilisateurs</h5>
                <p>Ajouter, modifier ou supprimer des comptes utilisateurs.</p>
                <a href="gestionUsers.jsp" class="btn btn-dark">Accéder</a>
            </div>
        </div>
        <!-- Gestion des Quiz -->
        <div class="col-md-4">
            <div class="card text-center p-4">
                <i class="fas fa-edit card-icon"></i>
                <h5 class="card-title">Créer & gérer les Quiz</h5>
                <p>Ajouter de nouvelles questions ou modifier les existantes.</p>
                <a href="gestionQuiz.jsp" class="btn btn-dark">Accéder</a>
            </div>
        </div>
        <!-- Statistiques -->
        <div class="col-md-4">
            <div class="card text-center p-4">
                <i class="fas fa-chart-bar card-icon"></i>
                <h5 class="card-title">Statistiques</h5>
                <p>Visualiser les résultats globaux des participants.</p>
                <a href="stats.jsp" class="btn btn-dark">Voir Stats</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
