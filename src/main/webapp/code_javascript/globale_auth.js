const password = document.getElementById('pass');
const confirmPassword = document.getElementById('confirm');
const form = document.getElementById('formInscription');
const passwordMessage = document.getElementById('passwordMessage');

const regexMajSpec = /^(?=.*[A-Z])(?=.*[^A-Za-z\d])/;

function validatePassword() {
    password.classList.remove('is-invalid');
    confirmPassword.classList.remove('is-invalid');
    passwordMessage.style.display = 'none';

    // Vérifier la complexité du mot de passe seulement si le champ n'est pas vide
    if (password.value && !regexMajSpec.test(password.value)) {
        password.classList.add('is-invalid');
        passwordMessage.textContent = "Le mot de passe doit contenir au moins une majuscule et un caractère spécial.";
        passwordMessage.style.display = 'block';
        return false;
    }

    // Vérifier la correspondance seulement si les deux champs sont remplis
    if (password.value && confirmPassword.value && password.value !== confirmPassword.value) {
        password.classList.add('is-invalid');
        confirmPassword.classList.add('is-invalid');
        passwordMessage.textContent = "Les mots de passe ne correspondent pas.";
        passwordMessage.style.display = 'block';
        return false;
    }

    return true;
}

// Événements
password.addEventListener('input', validatePassword);
confirmPassword.addEventListener('input', validatePassword);

form.addEventListener('submit', function(event) {
    if (!validatePassword()) {
        event.preventDefault();
        event.stopPropagation();
    }
});
