<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Brazza Sani - Une ville plus propre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-text-color: #0c0c0c;
            --secondary-text-color: #555;
            --brand-blue: #007bff;
            --brand-green: #28a745;
            --light-bg: #ffffff;
            --dark-bg-footer: #1a1a1a;
            --border-color: #e0e0e0;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light-bg);
            color: var(--primary-text-color);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .navbar {
            padding: 1rem 0;
            background-color: var(--light-bg);
            border-bottom: 1px solid var(--border-color);
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
            color: var(--primary-text-color) !important;
            display: flex;
            align-items: center;
        }
        .navbar-brand i {
            color: var(--brand-blue);
            margin-right: 0.5rem;
        }
        .nav-link {
            color: var(--secondary-text-color) !important;
            font-weight: 500;
            margin-right: 1.5rem;
        }
        .nav-link:hover {
            color: var(--brand-blue) !important;
        }
        .btn-outline-primary {
            border-color: var(--brand-blue);
            color: var(--brand-blue);
        }
        .btn-outline-primary:hover {
            background-color: var(--brand-blue);
            color: white;
        }
        .btn-primary {
            background-color: var(--brand-blue);
            border-color: var(--brand-blue);
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .hero-section {
            display: flex;
            flex-grow: 1;
            min-height: calc(100vh - 70px);
        }
        .hero-left {
            flex: 1;
            padding: 6rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            background-color: var(--light-bg);
        }
        .hero-left h1 {
            font-size: 3.8rem;
            font-weight: 700;
            line-height: 1.1;
            color: var(--primary-text-color);
            margin-bottom: 1.5rem;
        }
        .hero-left p {
            font-size: 1.25rem;
            color: var(--secondary-text-color);
            margin-bottom: 2.5rem;
            line-height: 1.6;
        }
        .hero-left .btn {
            font-weight: 600;
            padding: 0.9rem 2.2rem;
            border-radius: 8px;
            margin-right: 1rem;
            font-size: 1.05rem;
        }
        .btn-main-action {
            background-color: var(--brand-green);
            border-color: var(--brand-green);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            transition: all 0.3s ease;
        }
        .btn-main-action:hover {
            background-color: #218838;
            border-color: #218838;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }
        .btn-secondary-action {
            background-color: transparent;
            border: 1px solid var(--brand-blue);
            color: var(--brand-blue);
            transition: all 0.3s ease;
        }
        .btn-secondary-action:hover {
            background-color: var(--brand-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.2);
        }
        .hero-right {
            flex: 1;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNzMwIiBoZWlnaHQ9IjQ4NSIgdmlld0JveD0iMCAwIDczMCA0ODUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Ik0wIDYuNjIyMTZMNTYzLjUyNiAxMDMuOTIzTDU1NS4xNjMgNDgxLjg5TDkuMTI3MTQgNDIyLjE2MUwwIDYuNjIyMTZMNTYzLjUyNiAxMDMuOTIzWiIgZmlsbD0iI0E0QTk0RiIvPgo8cGF0aCBkPSJNNjQ1LjYzNyAwLjA1OTI4OTZMNzMwLjAwMiAxMjkuMDk1TDU1NS4wNDEgNDgxLjk2TDI3NC4zMzIgMzI1LjA3NkwzOTMuNjY3IDEwNS4wMDRMNjQ1LjYzNyAwLjA1OTI4OTZaIiBmaWxsPSIjMjU3NUZDIi8+CjxwYXRoIGQ9Ik0zOTMuNTQ2IDEwNS4wNzRMNTA5Ljg4IDI5NC40NjhMMjc0LjE2NiAzMjUuMTMyTDIzMi44NzIgMTYzLjA4OEwzOTMuNTQ2IDEwNS4wNzRaIiBmaWxsPSIjRkY5ODAwIi8+Cjwvc3ZnPgo=');
            background-size: cover;
            background-position: center;
            min-height: 400px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .hero-right::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 123, 255, 0.2), rgba(40, 167, 69, 0.2));
            pointer-events: none;
        }
        .floating-card {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            padding: 1.5rem 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            max-width: 300px;
            position: absolute;
            animation: float 3s ease-in-out infinite;
        }
        .floating-card.top-left { top: 15%; left: 10%; }
        .floating-card.bottom-right { bottom: 15%; right: 10%; }
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
        footer {
            background-color: var(--dark-bg-footer);
            color: #ccc;
            padding: 3rem 0;
            font-size: 0.9rem;
        }
        footer .list-unstyled a {
            color: #bbb;
        }
        footer .list-unstyled a:hover {
            color: white;
        }
        footer .text-uppercase {
            color: white;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        footer .social-icons a {
            font-size: 1.5rem;
            margin-right: 1rem;
            color: #bbb;
            transition: color 0.3s;
        }
        footer .social-icons a:hover {
            color: white;
        }
        @media (max-width: 992px) {
            .hero-section {
                flex-direction: column;
                min-height: auto;
                height: auto;
            }
            .hero-left {
                padding: 4rem 2rem;
                text-align: center;
                align-items: center;
            }
            .hero-left h1 {
                font-size: 2.8rem;
            }
            .hero-left p {
                font-size: 1.1rem;
            }
            .hero-left .btn {
                width: 100%;
                margin: 0.5rem 0;
            }
            .hero-right {
                min-height: 350px;
            }
            .floating-card.top-left, .floating-card.bottom-right {
                position: static;
                margin: 1rem auto;
            }
        }
        @media (max-width: 576px) {
            .hero-left h1 {
                font-size: 2.2rem;
            }
            .hero-left p {
                font-size: 1rem;
            }
            .navbar-brand {
                font-size: 1.2rem;
            }
            .navbar .ms-auto .btn {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-hand-holding-water"></i> Brazza heatlth
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Produits</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Solutions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Ressources</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Tarifs</a>
                    </li>
                </ul>
                <div class="d-flex">
                    <a href="<%= request.getContextPath() %>/register_connexion" class="btn btn-outline-primary me-2">Se connecter</a>
                    <a href="<%= request.getContextPath() %>/register_inscription" class="btn btn-primary">S'inscrire</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="hero-section">
        <div class="hero-left">
            <h1>Pour un Brazzaville Propre et Sûr.</h1>
            <p>
                La plateforme citoyenne collaborative pour l'assainissement de Brazzaville. Signalez les problèmes, partagez des solutions et agissez pour un meilleur environnement.
            </p>
            <div class="d-flex flex-column flex-sm-row mt-4">
                <a href="<%= request.getContextPath() %>/register_inscription" class="btn btn-lg btn-main-action mb-2 mb-sm-0 me-sm-3">
                    Rejoindre gratuitement
                </a>
               
            </div>
        </div>
        <div class="hero-right">
            <div class="floating-card top-left">
                <p class="mb-0"><i class="fas fa-check-circle text-success me-2"></i> <strong>75%</strong> des signalements résolus</p>
            </div>
            <div class="floating-card bottom-right">
                <p class="mb-0"><i class="fas fa-heart text-danger me-2"></i> Adoré par la communauté !</p>
            </div>
        </div>
    </main>

    <footer class="text-center text-lg-start">
        <div class="container p-4">
            <div class="row">
                <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Brazza heatlth</h5>
                    <p>
                        Une initiative citoyenne pour un environnement plus propre et une meilleure santé publique à Brazzaville.
                    </p>
                    <div class="social-icons mt-3">
                        <a href="#!" class="me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#!" class="me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#!" class="me-3"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Liens Utiles</h5>
                    <ul class="list-unstyled mb-0">
                        <li><a href="#!">À Propos</a></li>
                        <li><a href="#!">Nos Services</a></li>
                        <li><a href="#!">Contact</a></li>
                        <li><a href="#!">FAQ</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Contact</h5>
                    <ul class="list-unstyled mb-0">
                        <li><a href="#!"><i class="fas fa-envelope me-2"></i>info@brazzasani.com</a></li>
                        <li><a href="#!"><i class="fas fa-phone me-2"></i>+242 XX XXX XX XX</a></li>
                        <li><a href="#!"><i class="fas fa-map-marker-alt me-2"></i>Brazzaville, Congo</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
            &copy; 2025 Brazza Sani. Tous droits réservés.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>