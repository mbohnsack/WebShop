import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/buchungStorno")
public class buchungStorno extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String neuStatus = request.getParameter("aendern");
        int buchungsID = Integer.parseInt(request.getParameter("buchungsID"));
        String message = "Storno erfolgreich.";

        DatabaseHelper db = new DatabaseHelper();
        if(!db.updateBuchungsstatus(buchungsID,neuStatus)){
           message = "Buchung konnte nicht storniert werden.";
        }
        db.disconnectDatabase();

        request.setAttribute("message", message);
        request.setAttribute("perMail", email);
        request.getRequestDispatcher("/buchungenKunde.jsp").forward(request, response);

    }
}
