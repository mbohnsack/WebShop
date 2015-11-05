import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        String tele = request.getParameter("telefon");
        String mobil = request.getParameter("mobil");
        String orga = request.getParameter("orga");

        String passwort = request.getParameter("passwort");
        String passwortBest = request.getParameter("passwortBest");

        if (plz == "") plz = "0";
        if (tele == "") tele = "0";
        if (mobil == "") mobil = "0";

        DatabaseHelper db = new DatabaseHelper();

        System.out.println(benutzername);

        //prüfen ob nutzername schon vorhanden
        if(!db.KundeFrei(benutzername)){
            eingabeFehler = true;
            message = "Der Nutzername ist schon vorhanden.";
        }

        //Zahleneingaben prüfen
        if(!eingabeFehler){
            try{
                plz_int = Integer.parseInt(plz);
            }catch(NumberFormatException e){
                eingabeFehler = true;
                message = "PLZ mit ung&uuml;ltigem Wert.";
            }
        }
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

        // prüfen ob PW übereinstimmen
        if (!eingabeFehler) {
            if (!passwort.contentEquals(passwortBest)) {
                eingabeFehler = true;
                message = "Die Passw&ouml;rter stimmen nicht &uuml;berein.";
            }
        }

        if (!eingabeFehler) {
            boolean result = db.createKunde(benutzername, passwort, nname, vname, strasse, hausnr, plz_int, ort, telefon_int, mobil_int, email, orga);
            if (!result){
                message = "Der Account konnte nicht erstellt werden.";
            }else{
                message = "Sie haben sich erfolgreich registriert.";
            }
        }

        db.disconnectDatabase();

        //textausgabe im formular
        request.setAttribute("message", message);
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}
