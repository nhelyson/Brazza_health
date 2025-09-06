package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/MeteoServlet")
public class MeteoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Mets ta clé API OpenWeatherMap ici
    private final String API_KEY = "f916791617c1b0fe7f1716a3df461eb7";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ville = "Brazzaville,CG"; // ville + code pays
        String urlString = "https://api.openweathermap.org/data/2.5/weather?q="
                + ville + "&appid=" + API_KEY + "&units=metric&lang=fr";

        response.setContentType("application/json");
        try {
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            conn.disconnect();

            // Renvoie le JSON au client
            response.getWriter().write(content.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\":\"Impossible de récupérer la météo.\"}");
        }
    }
}
