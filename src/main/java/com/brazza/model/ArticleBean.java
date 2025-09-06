package com.brazza.model;

import java.sql.Timestamp;

public class ArticleBean {
    private int id;
    private String titre;
    private String contenu;
    private String auteur;
    private Timestamp datePublication;
    private String imagePrincipale;
   
    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getContenu() { return contenu; }
    public void setContenu(String contenu) { this.contenu = contenu; }

    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }

    public Timestamp getDatePublication() { return datePublication; }
    public void setDatePublication(Timestamp datePublication) { this.datePublication = datePublication; }

    public String getImagePrincipale() { return imagePrincipale; }
    public void setImagePrincipale(String imagePrincipale) { this.imagePrincipale = imagePrincipale; }

   
}
