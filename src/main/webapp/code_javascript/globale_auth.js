document.addEventListener('DOMContentLoaded', function() {
          const password = document.getElementById('pass');
          const confirmPassword = document.getElementById('confirm');
          const form = document.getElementById('formInscription');
          const passwordMessage = document.getElementById('passwordMessage');

          // Regex pour vérifier : au moins 1 majuscule et 1 caractère spécial
          const regexMajSpec = /^(?=.*[A-Z])(?=.*[^A-Za-z\d])/;

          // Fonction de validation
          function validatePassword() {
              // Réinitialiser les messages d'erreur
              password.classList.remove('is-invalid');
              confirmPassword.classList.remove('is-invalid');
              passwordMessage.style.display = 'none';

              // Vérification de la correspondance des mots de passe
              if (password.value !== confirmPassword.value) {
                  password.classList.add('is-invalid');
                  confirmPassword.classList.add('is-invalid');
                  passwordMessage.textContent = "Les mots de passe ne correspondent pas.";
                  passwordMessage.style.display = 'block';
                  return false;
              }

              // Vérification des critères de complexité
              if (!regexMajSpec.test(password.value)) {
                  password.classList.add('is-invalid');
                  confirmPassword.classList.add('is-invalid');
                  passwordMessage.textContent = "Le mot de passe doit contenir au moins une majuscule et un caractère spécial.";
                  passwordMessage.style.display = 'block';
                  return false;
              }

              // Si tout est valide
              password.classList.remove('is-invalid');
              confirmPassword.classList.remove('is-invalid');
              return true;
          }

          // Écoute des événements en temps réel
          password.addEventListener('input', validatePassword);
          confirmPassword.addEventListener('input', validatePassword);

          // Gérer la soumission du formulaire
          form.addEventListener('submit', function(event) {
              if (!validatePassword()) {
                  event.preventDefault(); // Empêche l'envoi du formulaire si la validation échoue
                  event.stopPropagation();
              }
          }, false);
      });