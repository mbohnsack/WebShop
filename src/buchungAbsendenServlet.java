import de.jollyday.HolidayCalendar;
import de.jollyday.HolidayManager;
import project.DatabaseHelper;
import project.SendMailSSL;
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
import java.util.*;


@WebServlet("/buchungAbsendenservelet")
public class buchungAbsendenServlet
        extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {


        DatabaseHelper db = new DatabaseHelper();
        String email = "";
        String message = ""; //gibt erfolgs oder fehlermeldung aus
        String benutzername = "";
        boolean eingabeFehler = false;
        Date abholdatum  = null;
        Date abgabedatum = null;

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
                    rs.next();
                    email = rs.getString(12);
                    System.out.println(email);
                }catch(SQLException e){
                    e.printStackTrace();
                }
            }
        }else{
            //Pflicht auslesn
            email = request.getParameter("email");
            String vname = request.getParameter("vname");
            String nname = request.getParameter("nname");

            //optional auslesn
            String strasse = request.getParameter("strasse");
            String hausnr = request.getParameter("hausnr");
            String ort = request.getParameter("ort");
            String plz = request.getParameter("plz");
            String tele = request.getParameter("telefon");
            String mobil = request.getParameter("mobil");
            String orga = request.getParameter("orga");


            //erzeugt random user wegen primarykey und weil der  KD sich ja nich anmelden will
            String passwort = "h4x0r"; //;-P
            do {
                int zahl = (int)(Math.random() * 100000);
                benutzername = "x" + String.valueOf(zahl);
            }while (!db.KundeFrei(benutzername));


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

            // nutzerdaten hinterlegen mit randomuser und PW
             if (!eingabeFehler) {
                boolean result = db.createKunde(benutzername, passwort, nname, vname, strasse, hausnr, plz_int, ort, telefon_int, mobil_int, email, orga);
                if (result){
                    message = "F&uuml;r die Buchungsbearbeitung wurden Ihre Daten hinterlegt.";
                }else{
                    eingabeFehler = true;
                    message = "Die f&uuml;r die Buchungsbearbeitung notwendigen Daten konnten nicht hinterlegt werden.(Serverfehler)";
                }
            }
        }

        if (!eingabeFehler) {
            // Datum auslesen und parsen

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

            // Daten für die Rabatt Berechnung holen
            request.setAttribute("nutzerName", benutzername);
            request.setAttribute("userName", user);
            request.setAttribute("abholdatum", abholdatum);
            request.setAttribute("abgabedatum", abgabedatum);

            System.out.println("nutzer" + benutzername);
            System.out.println("user" + user);
            System.out.println("abhol" + abholdatum);
            System.out.println("abgab" + abgabedatum);


            // wenn abgabe vor abhol
            if(abgabedatum.before(abholdatum)){
                eingabeFehler = true;
                message = "Das Abgabedatum liegt vor dem Abholdatum!";
            }


            // Prüft ob ein Datum auf einen Feirtag fällt
            HolidayManager manager = HolidayManager.getInstance(HolidayCalendar.GERMANY);
            if (!eingabeFehler) {
                Calendar abholFeier = GregorianCalendar.getInstance();
                abholFeier.setTime(abholdatum);
                if (manager.isHoliday(abholFeier, "bw")) {
                    eingabeFehler = true;
                    message = "Das Abholdatum liegt an einem Feiertag.";
                }
            }
            if (!eingabeFehler) {
                Calendar abgabeFeier = GregorianCalendar.getInstance();
                abgabeFeier.setTime(abgabedatum);
                if(manager.isHoliday(abgabeFeier, "bw")){
                    eingabeFehler = true;
                    message = "Das Abgabedatum liegt an einem Feiertag.";
                }
            }

            if (!eingabeFehler) {
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
                System.out.println("Bcode: " + buchungsCode);
                if(buchungsCode != -1){
                    //Buchung erfolgreich
                    SendMailSSL.sendBuchungMail(email, buchungsCode);
                    request.setAttribute("buchCode", buchungsCode);
                    request.getRequestDispatcher("/summaryBuchung.jsp").forward(request, response);
                    System.out.println("hier");
                    return;
                }
                else{
                    //Buchung fehlgeschlagen
                    message = "Buchung fehlgeschlagen bitte erneut versuchen. (Serverfehler)";
                    System.out.println("da");
                }
            }
        }

        db.disconnectDatabase();

        request.setAttribute("message", message);
        request.getRequestDispatcher("/buchungAbsenden.jsp").forward(request, response);
    }
}