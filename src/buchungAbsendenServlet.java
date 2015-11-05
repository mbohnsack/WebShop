import project.DatabaseHelper;
import project.cart;
import project.loginCookie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@WebServlet("/buchungAbsendenservelet")
public class buchungAbsendenServlet
        extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {


        DatabaseHelper db = new DatabaseHelper();
        String email = "";
        String message = ""; //gibt erfolgs oder fehlermeldung aus
        boolean eingabeFehler = false;

        int plz_int = 0;
        int mobil_int = 0;
        int telefon_int = 0;


        // wenn KD angemeldet ist, brauch er nix anzugeben + den loginname des angemeldeten Nutzers auslesen
        String user = "";
        HttpSession session = request.getSession();
        loginCookie loginDaten = (loginCookie)
                session.getAttribute("loginCookie");
        if (loginDaten != null) {
            if (loginDaten.getRolle() == "Kunde") {
                user = loginDaten.getUsername();

                ResultSet rs = db.getKundenDatenByLogin(user);
                try{
                    email = rs.getString(12);
                }catch(SQLException e){
                    e.printStackTrace();
                }
            }
        }else{
            //Pflicht auslesn
            email = request.getParameter("email");
            String vname = request.getParameter("vorname");
            String nname = request.getParameter("name");

            //optional auslesn
            String strasse = request.getParameter("strasse");
            String hausnr = request.getParameter("hausn");
            String ort = request.getParameter("ort");
            String plz = request.getParameter("plz");
            String tele = request.getParameter("tele");
            String mobil = request.getParameter("mobil");
            String orga = request.getParameter("orga");
            String benutzername = "";
            String passwort = "";

            //falls optionale int nicht eingegeben wurden wegen NumberFormatException
            if (plz == "") plz = "0";
            if (tele == "") tele = "0";
            if (mobil == "") mobil = "0";

            //Zahleneingaben prüfen
            try{
                plz_int = Integer.parseInt(plz);
            }catch(NumberFormatException e){
                eingabeFehler = true;
                message = "PLZ mit ung&uuml;ltigem Wert.";
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

            // nutzerdaten hinterlegen OHNE registrierung, PW(=""), login(="")
            // TODO erzeugt "leere" nutzer mit denen sich jeder anmelden kann....
            if (!eingabeFehler) {
                boolean result = db.createKunde(benutzername, passwort, nname, vname, strasse, hausnr, plz_int, ort, telefon_int, mobil_int, email, orga);
                if (!result){
                    message = "Für die Buchungsbearbeitung wurden Ihre Daten hinterlegt.";
                }else{
                    eingabeFehler = true;
                    message = "Die für die Buchungsbearbeitung notwendigen Daten konnten nicht hinterlegt werden.(Serverfehler)";
                }
            }
        }

        if (!eingabeFehler) {
            // Datum auslesen und parsen
            Date abholdatum  = null;
            Date abgabedatum = null;
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String abholungTemp = request.getParameter("abholung");
            String abgabeTemp = request.getParameter("abgabe");
            try{
                abholdatum = format.parse(abholungTemp);
            }catch(ParseException e){
                e.printStackTrace();
            }
            try{
                abgabedatum = format.parse(abgabeTemp);
            }catch(ParseException e){
                e.printStackTrace();
            }

            //Produktliste ausm cart holen
            cart shoppingCart;
            session = request.getSession();
            shoppingCart = (cart) session.getAttribute("cart");
            List<Integer> produktids = new ArrayList<Integer>();
            if(shoppingCart != null){
                //unchecked
                produktids = shoppingCart.getCartItems();
            }

            Integer buchungsCode = db.createBuchung(email, abholdatum, abgabedatum, produktids);

            if(buchungsCode != -1){
                //Buchung erfolgreich
                request.setAttribute("buchCode", buchungsCode);
                request.getRequestDispatcher("/summaryBuchung.jsp").forward(request, response);
            }
            else{
                //Buchung fehlgeschlagen
                message = "Buchung fehlgeschlagen bitte erneut versuchen.(Serverfehler)";
            }
        }

        db.disconnectDatabase();

        request.setAttribute("message", message);
        request.getRequestDispatcher("/buchungAbsenden.jsp").forward(request, response);

    }
}