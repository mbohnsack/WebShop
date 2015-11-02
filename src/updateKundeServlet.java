import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/updateKundeServlet")
public class updateKundeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        DatabaseHelper db = new DatabaseHelper();
        ResultSet kundenDaten = db.getKundenDaten(1); //Feld mit den alten Kundendaten einlesen

        Integer kun_nummer = 1; // muss ausm cookie kommen

        String passwort; // Übergibt je nachdem das neue oder alte PW
        String benutzer=""; //aktueller Benutzer, falls das Login geändert wird

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
        String pwNeu = request.getParameter("pwNeu");
        String pwNeuBest = request.getParameter("pwNeuBest");
        String pwAlt = request.getParameter("pw");

        // wenn keine Eingabe erfolgt werden die alten Daten übernommen
        try{
            while(kundenDaten.next()) {
                if (login.contentEquals(""))login = kundenDaten.getString(2);
                //wenn das login geändert wird altes login für die pw abfrage nutzen
                if (!login.contentEquals(""))benutzer = kundenDaten.getString(2);
                if (name.contentEquals("")) name = kundenDaten.getString(4);
                if (vorname.contentEquals("")) vorname = kundenDaten.getString(5);
                if (strasse.contentEquals("")) strasse = kundenDaten.getString(6);
                if (hausn.contentEquals("")) hausn = kundenDaten.getString(7);
                if (ort.contentEquals("")) ort = kundenDaten.getString(9);
                if (email.contentEquals("")) email = kundenDaten.getString(12);
                if (plz.contentEquals("")) plz = kundenDaten.getString(8);
                if (tele.contentEquals("")) tele = kundenDaten.getString(10);
                if (mobil.contentEquals("")) mobil = kundenDaten.getString(11);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }

        // Zahlenformate müssen aus den eingabefeldern geparst werden
        int plz_int = Integer.parseInt(plz);
        int tele_int = Integer.parseInt(tele);
        int mobil_int = Integer.parseInt(mobil);


        // wenn kein neues PW eingegeben wurde oder die PW nicht übereinstimmen fehler bzw altes pw
        if (!pwNeu.contentEquals("") && pwNeu.contentEquals(pwNeuBest)){
            passwort = pwNeu;
        }
        else{
            passwort = pwAlt;
        }

        // nur bei eingabe des gültigen PW werden die Daten in die DB geschrieben
        if (db.loginKunde(benutzer, pwAlt)){
            db.updateKundenDaten(kun_nummer, name, vorname, strasse, ort, email, hausn, plz_int, tele_int, mobil_int, passwort, login);
            //Daten erfolgreich übernommen
        }
        else{
            // PW stimmte nicht -> redirect Daten wurden nicht übernommen
        }

        String url = "/kundeBearbeiten.jsp";
        response.sendRedirect(url);

    }
}