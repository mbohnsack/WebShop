import project.DatabaseHelper;
import project.loginCookie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deleteKundeServlet")
public class deleteKundeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        DatabaseHelper db = new DatabaseHelper();
        HttpSession session = request.getSession();



        // hier könnte noch die PW abfrage rein


        String user = "";
        loginCookie loginDaten = (loginCookie)
                session.getAttribute("loginCookie");
        if (loginDaten != null) {
            if (loginDaten.getRolle() == "Kunde") {
                user = loginDaten.getUsername();
            }
        }

        db.deleteKunde(user); //KD löschen
        session.removeAttribute("loginCookie"); //cookie attribut entfernen

        db.disconnectDatabase();

        String url = "index.jsp";
        response.sendRedirect( url );





    }
}
