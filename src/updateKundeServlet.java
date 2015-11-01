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


        // code to process the form...

        Integer kun_nummer = 1;

        String vorname = request.getParameter("vorname");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String strasse = request.getParameter("strasse");
        String hausn = request.getParameter("hausn");
        String ort = request.getParameter("ort");
/*
        int plz = Integer.parseInt(request.getParameter("plz"));
        int tele = Integer.parseInt(request.getParameter("tele"));
        int mobil = Integer.parseInt(request.getParameter("mobil"));

        String pwNeu = request.getParameter("pwNeu");
        String pwNeuBest = request.getParameter("pwNeuBest");
        String pw = request.getParameter("pw");
*/


        System.out.println(name);
        System.out.println(vorname);

        try{
            while(kundenDaten.next()) {
                if (name.contentEquals("")) name = kundenDaten.getString(4);
                if (vorname.contentEquals("")) vorname = kundenDaten.getString(5);


                if (strasse == null) {
                    strasse = kundenDaten.getString(6);
                }
                if (hausn == null) {
                    hausn = kundenDaten.getString(7);
                }
                if (ort == null) {
                    ort = kundenDaten.getString(9);
                }
                if (email == null) {
                    email = kundenDaten.getString(12);
                }
                /*
                if (plz == 0) {
                    name = kundenDaten.getString(8);
                }

                if (tele == 0) {
                    name = kundenDaten.getString(10);
                }
                if (mobil == 0) {
                    name = kundenDaten.getString(11);
                }
                */
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }


        System.out.println(name);
        System.out.println(vorname);

        db.updateKundenDaten(kun_nummer, name, vorname);


        String url = "/kundeBearbeiten.jsp";
        response.sendRedirect(url);



/*
        if (!pwNeu.equals(null)){
            if (!pwNeu.equals(pwNeuBest)){
                // Seite wird mit warnhinweis erneut angezeigt
                PrintWriter out = response.getWriter();
                out.println("<font color=red>Neues Passwort keine Übereinstimmung.</font>");
                System.out.println("PW nich gleich");
            }
            else{
                passwort = pwNeu;
            }

        }
*/

/*
        if (db.loginKunde(user, pw)){
            db.updateKunde(kun_nummer, user, name, vorname, strasse, hausn, plz, ort, tele, mobil, email, passwort);
            System.out.println("geändert");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/general/setCookie.jsp");
            System.out.println("Test II");
            rd.forward(request, response);
        }
*/



        /*

        else{
            //Seite wird erneut mit warnhinweis angezeigt
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Passwort falsch.</font>");
        }

*/


    }
}