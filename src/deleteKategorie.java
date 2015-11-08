import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by filip on 08.11.2015.
 */
@WebServlet("/deleteKategorie")
public class deleteKategorie extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String katName = request.getParameter("loeschen");

        DatabaseHelper db = new DatabaseHelper();
        db.deleteKategorie(katName);

        String url = "/MitarbeiterView/kategorieVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
    }
}