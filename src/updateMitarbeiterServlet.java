import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Chris on 02.11.2015.
 */
@WebServlet("/updateMitarbeiterServlet")
public class updateMitarbeiterServlet extends HttpServlet{
    //Ändern der Rolle eines Mitarbeiters/Admins
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String mitarbeiterUsername = request.getParameter("username");
        String rolle = request.getParameter("rolle");


        DatabaseHelper db = new DatabaseHelper();
        db.updateMitarbeiter(rolle,mitarbeiterUsername);
        db.disconnectDatabase();
        String url = "/MitarbeiterView/mitarbeiterVerwalten.jsp";
        response.sendRedirect(url);

    }
}
