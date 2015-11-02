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
@WebServlet("/deleteMitarbeiterServelt")
public class deleteMitarbeiterServelt extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String mitarbeiterUsername = request.getParameter("loeschen");

        DatabaseHelper db = new DatabaseHelper();
        db.deleteMitarbeiter(mitarbeiterUsername);

        String url = "/MitarbeiterView/mitarbeiterVerwalten.jsp";
        response.sendRedirect( url );
    }
}
