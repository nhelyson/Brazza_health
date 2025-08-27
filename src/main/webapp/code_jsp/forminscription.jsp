<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f5f2;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .main-container {
            display: flex;
            width: 100vw;
            height: 100vh;
            background-color: #fff;
            border-radius: 0;
            box-shadow: none;
            overflow: hidden;
        }

        .left-panel {
            flex: 1;
            background-color: #ff6f00;
            padding: 40px;
            color: #fff;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .left-panel .logo {
            position: absolute;
            top: 20px;
            left: 20px;
            display: flex;
            align-items: center;
        }
        
        .left-panel .logo-circle {
            width: 30px;
            height: 30px;
            border: 2px solid #fff;
            border-radius: 50%;
        }

        .left-panel .logo-text {
            margin-left: 10px;
            font-weight: bold;
        }
        
        .left-panel h2 {
            margin-top: 150px;
            font-size: 2rem;
            line-height: 1.2;
            font-weight: bold;
        }

        .left-panel .illustration {
            width: 100%;
            height: auto;
            max-width: 300px;
            margin-top: 20px;
        }

        .left-panel p {
            font-size: 0.8rem;
            margin-top: 20px;
            opacity: 0.8;
            max-width: 80%;
        }
        
        .right-panel {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .form-content {
            width: 100%;
            max-width: 500px;
        }
        
        .form-content h3 {
            font-weight: 500;
            margin-bottom: 30px;
            text-align: center;
        }

        /* Champs redimensionnés */
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 8px 12px; /* Réduction du padding vertical */
            height: auto; /* Ajustement automatique de la hauteur */
            background-color: #f7f9fc;
            font-size: 1rem;
        }
        
        .btn-custom {
            background-color: #ff6f00;
            border: none;
            border-radius: 8px;
            padding: 12px;
            width: 100%;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #e56300;
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .login-link a {
            color: #ff6f00;
            text-decoration: none;
            font-weight: 500;
        }

        /* Styles responsifs */
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                height: auto;
            }
            .left-panel {
                display: none;
            }
            .right-panel {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="left-panel">
            <div class="logo">
                <div class="logo-circle"></div>
                <span class="logo-text">LOGO</span>
            </div>
            <h2>Créer un Compte</h2>
            <img src="https://i.ibb.co/L5kR7wF/capture-d-ecran-2025-08-15-154846.jpg" alt="Illustration" class="illustration">
            <p>
                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
            </p>
        </div>

        <div class="right-panel">
            <div class="form-content">
                <h3>Créer un Compte</h3>
                <form action="<%= request.getContextPath() %>/inscriptionServlet" method="post" id="formInscription">

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Prénom</label>
                            <input type="text" name="prenom" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Nom</label>
                            <input type="text" name="nom" class="form-control" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Téléphone</label>
                            <input type="tel" name="telephone" class="form-control" required>
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
                            <option value="autre">Autre</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mot de passe</label>
                        <input type="password" name="motdepasse" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Confirmer le mot de passe</label>
                        <input type="password" name="confirmMotdepasse" class="form-control" required>
                    </div>

                    <button type="submit" class="btn btn-custom text-white fw-bold">S'inscrire</button>
                </form>
                
                <p class="login-link">Déjà un compte ? <a href="connexion.jsp">Se connecter</a></p>
            </div>
        </div>
    </div>
</body>
</html>