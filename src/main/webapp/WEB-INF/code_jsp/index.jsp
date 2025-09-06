<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - Brazza Health</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c7be5;
            --secondary-color: #f2f6fc;
            --accent-color: #28a745;
            --text-color: #333;
            --light-text-color: #777;
            --bg-color: #f0f4f8;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        body {
            background-color: var(--bg-color);
            font-family: 'Poppins', sans-serif;
            color: var(--text-color);
        }
        .main-content {
            padding: 2rem 1rem;
        }
        .section-header {
            margin-bottom: 2rem;
            text-align: center;
        }
        .section-header h2 {
            font-weight: 700;
            color: var(--primary-color);
        }
        .hero-section {
            background-color: var(--primary-color);
            color: #fff;
            padding: 3rem 1rem;
            text-align: center;
            border-radius: 1rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        .hero-section h1 {
            font-weight: 700;
            font-size: 2.5rem;
        }
        .hero-section p {
            font-weight: 300;
            font-size: 1.1rem;
            opacity: 0.9;
        }
        .card-row {
            display: grid;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        @media (min-width: 992px) {
            .card-row {
                grid-template-columns: 1fr 2fr;
            }
        }
        .card {
            background-color: #fff;
            border-radius: 1rem;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-title {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }
        .card-title i {
            margin-right: 0.5rem;
        }
        /* Météo Card */
        .weather-card .main-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        .weather-card .temperature {
            font-size: 3rem;
            font-weight: 300;
        }
        .weather-card .location {
            font-size: 1.5rem;
            font-weight: 500;
        }
        .weather-card .weather-icon {
            width: 80px;
            height: 80px;
        }
        .weather-card .details-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            text-align: center;
            gap: 1rem;
            margin-top: 1rem;
        }
        .details-grid .item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .details-grid .item i {
            font-size: 1.25rem;
            color: var(--primary-color);
        }
        .details-grid .item span {
            font-size: 0.8rem;
            color: var(--light-text-color);
            margin-top: 0.25rem;
        }
        .details-grid .item p {
            margin: 0;
            font-weight: 500;
        }
        /* Articles Card */
        .articles-card ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .articles-card ul li {
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }
        .articles-card ul li:last-child {
            border-bottom: none;
        }
        .articles-card ul li a {
            color: var(--text-color);
            font-weight: 400;
            transition: color 0.3s ease;
        }
        .articles-card ul li a:hover {
            color: var(--primary-color);
            text-decoration: none;
        }
        /* CTA Section */
        .cta-section {
            background-color: var(--secondary-color);
            padding: 3rem 1rem;
            border-radius: 1rem;
            text-align: center;
            box-shadow: var(--card-shadow);
        }
        .cta-section h4 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-color);
        }
        .cta-section .btn {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 500;
            text-transform: uppercase;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .cta-section .btn:hover {
            background-color: #235fa7;
            transform: translateY(-2px);
        }
        /* New Sections */
        .features-carousel {
            margin-bottom: 2rem;
        }
        .feature-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
            text-align: center;
        }
        .feature-item .feature-icon {
            font-size: 3rem;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }
        .feature-item h5 {
            font-weight: 600;
            font-size: 1.25rem;
        }
        .feature-item p {
            font-size: 0.9rem;
            color: var(--light-text-color);
        }
        .news-section .news-item {
            background-color: #fff;
            border-radius: 1rem;
            box-shadow: var(--card-shadow);
            padding: 1rem;
            margin-bottom: 1rem;
            transition: transform 0.3s ease;
        }
        .news-section .news-item:hover {
            transform: translateY(-3px);
        }
        .news-item h5 {
            font-size: 1rem;
            font-weight: 600;
            color: var(--primary-color);
        }
        .news-item p {
            font-size: 0.85rem;
            color: var(--light-text-color);
            margin-bottom: 0;
        }
        footer {
            background-color: #1a202c;
            color: #fff;
            padding: 2rem 1rem;
            text-align: center;
        }
        .footer-links a {
            color: #fff;
            margin: 0 1rem;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }
        .footer-links a:hover {
            color: var(--primary-color);
        }
        .social-icons a {
            color: #fff;
            font-size: 1.5rem;
            margin: 0 0.5rem;
            transition: color 0.3s ease;
        }
        .social-icons a:hover {
            color: var(--primary-color);
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container main-content">
    
    <div class="hero-section">
        <h1>Brazza Health</h1>
        <p>Votre portail pour une ville plus saine et un quotidien mieux informé.</p>
    </div>
    
    <div class="features-carousel">
        <div id="featuresCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="feature-item">
                        <i class="fas fa-check-circle feature-icon"></i>
                        <h5>Signalez un Problème</h5>
                        <p>Aidez-nous à garder notre ville propre en signalant inondations et dépotoirs sauvages.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="feature-item">
                        <i class="fas fa-hand-holding-heart feature-icon"></i>
                        <h5>Restez Informé</h5>
                        <p>Accédez à des articles et des conseils pour la santé de votre famille.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="feature-item">
                        <i class="fas fa-cloud-sun-rain feature-icon"></i>
                        <h5>Anticipez le Climat</h5>
                        <p>Consultez la météo en temps réel pour mieux gérer votre quotidien.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#featuresCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Précédent</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#featuresCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Suivant</span>
            </button>
        </div>
    </div>

    <div class="card-row">
        <div id="meteo-container" class="card weather-card">
            <h4 class="card-title text-center">Météo à Brazzaville</h4>
            <p class="text-center text-muted">Chargement des données météo...</p>
        </div>

        <div class="card articles-card">
            <h4 class="card-title"><i class="fas fa-bullhorn"></i> Nouvelles de la Communauté</h4>
            <div class="news-section">
                <div class="news-item">
                    <h5>Lancement du projet de drainage dans le quartier de Talangaï</h5>
                    <p>La mairie a annoncé le début des travaux pour améliorer le réseau d'assainissement...</p>
                </div>
                <div class="news-item">
                    <h5>Campagne de sensibilisation à l'hygiène : rejoignez-nous !</h5>
                    <p>Des ateliers de sensibilisation seront organisés dans 5 quartiers de la ville...</p>
                </div>
                <div class="news-item">
                    <h5>Conseils pour éviter les maladies en cas de forte pluie</h5>
                    <p>Découvrez les gestes simples pour protéger votre famille lors des inondations...</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="cta-section">
        <h4 class="mb-3">Votre participation est essentielle</h4>
        <p class="mb-4">Contribuez à un environnement plus sain en signalant un problème ou en partageant vos idées.</p>
        <a href="${pageContext.request.contextPath}/Affiche_wiki" class="btn"><i class="fas fa-plus-circle me-2"></i>Signaler un Problème</a>
    </div>

</div>
<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
   const contextPath = "<%= request.getContextPath() %>";
</script>
<script src="<%= request.getContextPath() %>/code_javascript/meteo.js"></script>
</body>
</html>