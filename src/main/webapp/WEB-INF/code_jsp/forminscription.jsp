<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/code_css/stylesingup.css">
    <style>
        .left-panel {
            flex: 1;
            overflow:hidden;
            background-image: url('image/dechet.jpg');
            background-size: cover;
            padding: 40px;
            color: #fff;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            z-index:1;
        }
        .left-panel::after{
            content: "";
            position: absolute;
            top: 0;
            bottom: 0;
            left:0;
            right:0;
            z-index: -1;
            background: inherit;
            filter: brightness(0.7);
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="left-panel">
        <div class="logo">
            <div class="logo-circle"></div>
            <span class="logo-text">brazza health</span>
        </div>
        <h2>Créer un Compte</h2>
        <p>Essayez en temps réel les données sur l'assainissement de Brazzaville et échangez dans la communauté pour faire avancer les choses</p>
    </div>

    <div class="right-panel">
        <div class="form-content">
            <h3>Créer un Compte</h3>
            <form action="${pageContext.request.contextPath}/Inscription" method="post" id="formInscription">

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Prénom</label>
                        <input type="text" name="prenom" placeholder="Prénom" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Nom</label>
                        <input type="text" name="nom" placeholder="Nom" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" placeholder="Email@gmail.com" class="form-control" required>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Téléphone</label>
                        <input type="tel" name="telephone" placeholder="Numéro de téléphone" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Date de naissance</label>
                        <input type="date" name="dateNaissance" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Genre</label>
                    <select name="genre" class="form-select" required>
                        <option value="" disabled selected>Sélectionnez votre genre</option>
                        <option value="homme">Homme</option>
                        <option value="femme">Femme</option>
                        <option value="autre">Woubi</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mot de passe</label>
                    <input type="password" name="motdepasse" id="pass" placeholder="Mot de passe" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Confirmer le mot de passe</label>
                    <input type="password" name="confirmMotdepasse" id="confirm" placeholder="Confirmez le mot de passe" class="form-control" required>
                    <div id="passwordMessage" class="text-danger mt-1" style="display:none;"></div>
                </div>

                <button type="submit" class="btn btn-custom text-white fw-bold">S'inscrire</button>
            </form>
            
            <p class="login-link">Déjà un compte ? <a href="${pageContext.request.contextPath}/register_connexion">Se connecter</a></p>
        </div>
    </div>
</div>
<script src="<%= request.getContextPath() %>/code_javascript/globale_auth.js"></script>
</body>
</html>
