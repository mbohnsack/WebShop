import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;

/**
 * Created by filip on 02.11.2015.
 */

@WebServlet("/registerKundeServlet")
public class registerKundeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String message = ""; //gibt erfolgs oder fehlermeldung aus
        boolean eingabeFehler = false;

        int plz_int = 0;
        int mobil_int = 0;
        int telefon_int = 0;


        //Alle Daten aus den Felder lesen
        String benutzername = request.getParameter("benutzername");
        String nname = request.getParameter("nname");
        String vname = request.getParameter("vname");
        String email = request.getParameter("email");
        String strasse = request.getParameter("strasse");
        String hausnr = request.getParameter("hausnr");
        String ort = request.getParameter("ort");
        String plz = request.getParameter("plz");
        String tele = request.getParameter("tele");
        String mobil = request.getParameter("mobil");
        String orga = request.getParameter("orga");
        String passwort = request.getParameter("passwort");
        String passwortBest = request.getParameter("passwortBest");

        /*
        // pr�fen, ob optionale nummernfelder leer sind wegen exception
        if(plz.contentEquals("")){plz="0";}
        if(tele.contentEquals("")){tele="0";}
        if(mobil.contentEquals("")){mobil="0";}
        */

        DatabaseHelper db = new DatabaseHelper();

        System.out.println(benutzername);

        //pr�fen ob nutzername schon vorhanden
        if(!db.KundeFrei(benutzername)){
            eingabeFehler = true;
            message = "Der Nutzername ist schon vorhanden.";
        }
        db.disconnectDatabase();


        //Zahleneingaben pr�fen
        if(!eingabeFehler){
            try{
                plz_int = Integer.parseInt(plz);
            }catch(NumberFormatException e){
                eingabeFehler = true;
                message = "PLZ mit ung&uuml;ltigem Wert.";
            }
        }
        //TODO vorangestellte 0 kann nicht angezeit/gespeichert werden; mobil und tele
        if(!eingabeFehler){
            try{
                telefon_int = Integer.parseInt(tele);
            }catch(NumberFormatException e){
                eingabeFehler = true;
                message = "Telefonnummer mit ung&uuml;ltigem Wert.";
            }
        }
        if(!eingabeFehler){
            try{
                mobil_int = Integer.parseInt(mobil);
            }catch(NumberFormatException e){
                eingabeFehler = true;
                message = "Mobilnummer mit ung&uuml;ltigem Wert.";
            }
        }

        // pr�fen ob PW �bereinstimmen
        if (!eingabeFehler) {
            if (passwort != passwortBest) {
                eingabeFehler = true;
                message = "Die Passw�rter stimmen nicht &uuml;berein.";
            }
        }

        if (!eingabeFehler) {
            boolean result = db.createKunde(benutzername, passwort, nname, vname, strasse, hausnr, plz_int, ort, telefon_int, mobil_int, email, orga);
            if (result == false){ // ja geht auch anders aber fehlersuche-.-
                message = "Der Account konnte nicht erstellt werden.";
            }else{
                message = "Sie haben sich erfolgreich registriert.";
            }
        }

        //textausgabe im formular
        request.setAttribute("message", message);
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}
