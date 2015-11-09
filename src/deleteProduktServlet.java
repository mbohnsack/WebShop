import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Chris on 07.11.2015.
 */
@WebServlet("/deleteProduktServlet")
public class deleteProduktServlet extends HttpServlet {
    //Löschen eines Produktes incl. Bilder
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        int pakID = Integer.parseInt(request.getParameter("loeschen"));

        DatabaseHelper db = new DatabaseHelper();
        db.deleteProduct(pakID);

        String url = "/MitarbeiterView/produktVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
    }
}
