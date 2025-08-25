<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Application</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
     <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
  <link rel="stylesheet" href="stylesingup.css">
</head>
<body id="body_sign">
<div class="wrapper">
    <div class="left-panel text-center">
        <h1 class="mb-4">Pour un brazzaville plus propre</h1>
        <p>Lorem ipsum dolor sitse diam nonummy placeholder</p>
        <p style="font-size:0.85rem;">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
    </div>
    <div class="right-panel">
        <div class="form-card">
            <h2 class="text-center fw-bold">
             <i class="fa-solid fa-leaf me-2"></i> Créer un compte</h2>
            <form action="<%= request.getContextPath() %>/inscriptionServlet" method="post" id="formInscription">
                <div class="row mb-3">
                    <div class="col">
                        <label class="form-label">Prénom</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" name="prenom" class="form-control" placeholder="Votre prénom" required>
                        </div>
                    </div>
                    <div class="col">
                        <label class="form-label">Nom</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" name="nom" class="form-control" placeholder="Votre nom" required>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="exemple@mail.com" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mot de passe</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                        <input type="password" name="motdepasse" id="pass" class="form-control" placeholder="Mot de passe" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Confirmer le mot de passe</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                        <input type="password" name="confirmMotdepasse" id="confirm" class="form-control" placeholder="Confirmer le mot de passe" required>
                    </div>
                    <span id="confirmMessage" style="color:red; font-size:0.9em; display:none;"></span>
                </div>

                <div class="mb-4">
                    <label class="form-label">Téléphone</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                        <input type="tel" name="telephone" class="form-control" placeholder="+242 ..." required>
                    </div>
                </div>

                <button type="submit" class="btn btn-custom btn-lg text-white fw-bold">
                    <i class="fa-solid fa-user-plus me-2"></i> S'inscrire
                </button>
            </form>

            <p class="text-center mt-3">Déjà un compte ?
                <a href="connexion.jsp" class="text-link">Se connecter</a>
            </p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="globale_auth.js"></script>
</body>
</html>
