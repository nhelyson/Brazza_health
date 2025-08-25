
if(document.getElementById("body_sign")){
const password = document.getElementById("pass");
const confirm_pass = document.getElementById("confirm");
const confirmMessage = document.getElementById("confirmMessage");
const form = document.getElementById("formInscription");

// Regex pour vérifier : au moins 1 majuscule et 1 caractère spécial
const regexMajSpec = /^(?=.*[A-Z])(?=.*[^A-Za-z\d])/;

form.addEventListener("submit", function(e) {
	
    // Vérification majuscule et caractère spécial
    if (!regexMajSpec.test(password.value) &&  !regexMajSpec.test(confirm_pass.value)) {
        e.preventDefault(); // Bloque l'envoi du formulaire
        password.style.border = "2px solid red";
        confirm_pass.style.border = "1px solid #ced4da";
        confirmMessage.textContent = "Mot de passe invalide ! Il doit contenir au moins une majuscule et un caractère spécial.";
        confirmMessage.style.display = "block";
        return;
    }

    // Vérification de la correspondance
    if (password.value !== confirm_pass.value) {
        e.preventDefault();
        password.style.border = "2px solid red";
        confirm_pass.style.border = "2px solid red";
        confirmMessage.textContent = "Les mots de passe ne correspondent pas !";
        confirmMessage.style.display = "block";
    } else {
        password.style.border = "1px solid #ced4da";
        confirm_pass.style.border = "1px solid #ced4da";
        confirmMessage.style.display = "none";
    }
});

}

if(document.getElementById("body_connect")){

	// Placeholder dynamique pour identifiant
	const loginInput = document.getElementById("loginInput");

	loginInput.addEventListener("input", function() {
	    const value = loginInput.value;

	    if (value.includes("@")) {
	        loginInput.placeholder = "Votre email";
	    } else if (value.length > 0) {
	        loginInput.placeholder = "Nom d'utilisateur";
	    } else {
	        loginInput.placeholder = "Nom d'utilisateur ou email";
	    }
	});
}
