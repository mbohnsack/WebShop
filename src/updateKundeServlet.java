import project.DatabaseHelper;
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


@WebServlet("/updateKundeServlet")
public class updateKundeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        // den loginname des angemeldeten Nutzers auslesen
        String user = "";
        HttpSession session = request.getSession();
        loginCookie loginDaten = (loginCookie)
                session.getAttribute("loginCookie");
        if (loginDaten != null) {
            if (loginDaten.getRolle() == "Kunde") {
                user = loginDaten.getUsername();
            }
        }

        String passwort = ""; // Übergabewert falls das PW geändert wird
        Integer kun_nummer = 0;
        String message = ""; //gibt erfolgs oder fehlermeldung aus
        int plz_int = 0;
        int tele_int = 0;
        int mobil_int = 0;
        boolean eingabeFehler = false;

        String login = request.getParameter("login");
        String vorname = request.getParameter("vorname");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String strasse = request.getParameter("strasse");
        String hausn = request.getParameter("hausn");
        String ort = request.getParameter("ort");
        String plz = request.getParameter("plz");
        String tele = request.getParameter("tele");
        String mobil = request.getParameter("mobil");
        String orga = request.getParameter("orga");
        String pwNeu = request.getParameter("pwNeu");
        String pwNeuBest = request.getParameter("pwNeuBest");
        String pwAlt = request.getParameter("pw");

        DatabaseHelper db = new DatabaseHelper();


        ResultSet kundenDaten = db.getKundenDatenByLogin(user); //Feld mit den alten Kundendaten einlesen

        // wenn keine Eingabe erfolgt werden die alten Daten genommen
        try {
            while (kundenDaten.next()) {
                kun_nummer = Integer.parseInt(kundenDaten.getString(1));

                if (login.contentEquals("")) login = kundenDaten.getString(2);
                if (name.contentEquals("")) name = kundenDaten.getString(4);
                if (vorname.contentEquals("")) vorname = kundenDaten.getString(5);
                if (strasse.contentEquals("")) strasse = kundenDaten.getString(6);
                if (hausn.contentEquals("")) hausn = kundenDaten.getString(7);
                if (ort.contentEquals("")) ort = kundenDaten.getString(9);
                if (email.contentEquals("")) email = kundenDaten.getString(12);
                if (plz.contentEquals("")) plz = kundenDaten.getString(8);
                if (tele.contentEquals("")) tele = kundenDaten.getString(10);
                if (mobil.contentEquals("")) mobil = kundenDaten.getString(11);
                if (orga.contentEquals("")) orga = kundenDaten.getString(13);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Zahlenformate müssen aus den eingabefeldern geparst werden
        try {
            plz_int = Integer.parseInt(plz);
        } catch (NumberFormatException e) {
            eingabeFehler = true;
            message = "PLZ mit ung&uuml;ltigem Wert.";
        }
        //TODO vorangestellte 0 kann nicht angezeit/gespeichert werden; mobil und tele
        if (!eingabeFehler) {
            try {
                tele_int = Integer.parseInt(tele);
            } catch (NumberFormatException e) {
                eingabeFehler = true;
                message = "Telefonnummer mit ung&uuml;ltigem Wert.";
            }
        }
        if (!eingabeFehler) {
            try {
                mobil_int = Integer.parseInt(mobil);
            } catch (NumberFormatException e) {
                eingabeFehler = true;
                message = "Mobilnummer mit ung&uuml;ltigem Wert.";
            }
        }

        // wenn kein neues PW eingegeben wurde oder die PW nicht übereinstimmen fehler bzw altes pw
        if (!eingabeFehler) {
            if (!pwNeu.contentEquals("") && pwNeu.contentEquals(pwNeuBest)) {
                passwort = pwNeu;
            } else {
                passwort = pwAlt;
            }
            if (!pwNeu.contentEquals(pwNeuBest)) {
                eingabeFehler = true;
                message = "Die neuen Passw&ouml;rter stimmen nicht &uuml;berein.";
            }
        }

        // nur bei eingabe des gültigen PW werden die Daten in die DB geschrieben
        if (!eingabeFehler) {
            if (db.loginKunde(user, pwAlt)) {
                db.updateKundenDaten(kun_nummer, name, vorname, strasse, ort, email, hausn, plz_int, tele_int, mobil_int, passwort, login, orga);
                message = "Daten erfolgreich &uuml;bernommen.";
            } else {
                message = "Das Passwort stimmte nicht.";
                System.out.println("pw falsch");
            }
        }

        //textausgabe im formular
        request.setAttribute("message", message);
        request.getRequestDispatcher("/kundeBearbeiten.jsp").forward(request, response);

        db.disconnectDatabase();
    }

}