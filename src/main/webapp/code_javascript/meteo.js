const met = document.getElementById("meteo-container");

fetch(contextPath + "/MeteoServlet")
    .then(response => {
        if (!response.ok) {
            throw new Error('Réponse du serveur non valide : ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        console.log("Réponse servlet :", data);

        if (data && data.main && data.weather && data.name) {
            const temperature = data.main.temp;
            const description = data.weather[0].description;
            const location = data.name;
            const icon = data.weather[0].icon;

            const meteoHtml = `
                <div class="main-info">
                    <div>
                        <p class="location">${location}</p>
                        <p class="temperature">${temperature.toFixed(0)}°C</p>
                    </div>
                    <div>
                        <img src="http://openweathermap.org/img/wn/${icon}@2x.png" alt="Icône météo" class="weather-icon">
                        <p class="description text-muted text-capitalize">${description}</p>
                    </div>
                </div>
                <hr>
                <div class="details-grid">
                    <div class="item">
                        <i class="fas fa-tint"></i>
                        <p>${data.main.humidity}%</p>
                        <span>Humidité</span>
                    </div>
                    <div class="item">
                        <i class="fas fa-wind"></i>
                        <p>${data.wind.speed} m/s</p>
                        <span>Vent</span>
                    </div>
                    <div class="item">
                        <i class="fas fa-tachometer-alt"></i>
                        <p>${data.main.pressure} hPa</p>
                        <span>Pression</span>
                    </div>
                </div>
            `;
            
            met.innerHTML = meteoHtml;
        } else {
            met.innerHTML = "<p class='text-center text-muted'>Données météo non disponibles.</p>";
            console.error("Données météo incomplètes reçues :", data);
        }
    })
    .catch(err => {
        console.error("Erreur lors de la récupération des données météo :", err);
        met.innerHTML = "<p class='text-center text-danger'>Impossible de charger les données météo. Veuillez réessayer plus tard.</p>";
    });