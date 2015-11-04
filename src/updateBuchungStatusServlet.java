import project.DatabaseHelper;
import project.SendMailSSL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Chris on 04.11.2015.
 */
@WebServlet("/updateBuchungStatusServlet")
public class updateBuchungStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String neuStatus = request.getParameter("aendern");
        int buchungsID = Integer.parseInt(request.getParameter("buchungsID"));

        DatabaseHelper db = new DatabaseHelper();
        db.updateBuchungsstatus(buchungsID,neuStatus);
        db.disconnectDatabase();

        SendMailSSL.sendStatusUpdateMail(buchungsID,neuStatus);

        String url = "/MitarbeiterView/buchungsVerwaltung.jsp";
        response.sendRedirect(url);

    }
}
