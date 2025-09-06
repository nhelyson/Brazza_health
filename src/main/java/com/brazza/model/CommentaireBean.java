package com.brazza.model;

import java.sql.Timestamp;

public class CommentaireBean {
    private int id;
    private String contenu;
    private Timestamp dateCommentaire;
    private int utilisateurId;
    private int articleId;
    private String auteur; // Nom de l'utilisateur pour affichage
    private String photoAuteur; // <--- Nouvelle propriété pour la photo de profil du commentateur

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getContenu() { return contenu; }
    public void setContenu(String contenu) { this.contenu = contenu; }

    public Timestamp getDateCommentaire() { return dateCommentaire; }
    public void setDateCommentaire(Timestamp dateCommentaire) { this.dateCommentaire = dateCommentaire; }

    public int getUtilisateurId() { return utilisateurId; }
    public void setUtilisateurId(int utilisateurId) { this.utilisateurId = utilisateurId; }

    public int getArticleId() { return articleId; }
    public void setArticleId(int articleId) { this.articleId = articleId; }

    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }

    public String getPhotoAuteur() { return photoAuteur; }
    public void setPhotoAuteur(String photoAuteur) { this.photoAuteur = photoAuteur; }
}
