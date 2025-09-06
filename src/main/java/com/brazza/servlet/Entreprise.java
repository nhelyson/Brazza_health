package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Entreprise")
public class Entreprise extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Classe interne représentant une société
    public static class Societe {
        private String nom;
        private String description;
        private String adresse;
        private String telephone;
        private String email;
        private String siteWeb;
        private String lienMaps;

        public Societe(String nom, String description, String adresse, String telephone,
                       String email, String siteWeb, String lienMaps) {
            this.nom = nom;
            this.description = description;
            this.adresse = adresse;
            this.telephone = telephone;
            this.email = email;
            this.siteWeb = siteWeb;
            this.lienMaps = lienMaps;
        }

        public String getNom() { return nom; }
        public String getDescription() { return description; }
        public String getAdresse() { return adresse; }
        public String getTelephone() { return telephone; }
        public String getEmail() { return email; }
        public String getSiteWeb() { return siteWeb; }
        public String getLienMaps() { return lienMaps; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Création de la liste des sociétés d'assainissement à Brazzaville
        List<Societe> societes = new ArrayList<>();
        societes.add(new Societe(
                "Albayrak Waste Management",
                "Entreprise turque chargée de la collecte et du traitement des déchets solides urbains à Brazzaville et Pointe-Noire.",
                "Brazzaville, République du Congo",
                "+242 06 123 45 67",
                "contact@albayrak.cg",
                "https://www.albayrak.cg",
                "https://goo.gl/maps/example1"
        ));

        societes.add(new Societe(
                "Healthy Environment",
                "Société congolaise spécialisée dans l'assainissement urbain, la gestion des déchets et la protection de l'environnement.",
                "Brazzaville, République du Congo",
                "+242 06 987 65 43",
                "contact@healthyenvironment.cg",
                "https://www.healthyenvironment.cg",
                "https://goo.gl/maps/example2"
        ));

        societes.add(new Societe(
                "Société Congolaise d'Assainissement Urbain (SCAU)",
                "Opérateur local assurant la collecte des ordures et le ramassage dans plusieurs quartiers de Brazzaville.",
                "Brazzaville, République du Congo",
                "+242 05 523 25 54",
                "contact@scau.cg",
                "https://www.scau.cg",
                "https://goo.gl/maps/example3"
        ));

        // On place la liste dans la requête
        request.setAttribute("societes", societes);

        // Forward vers JSP
        request.getRequestDispatcher("/WEB-INF/code_jsp/entreprises.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
