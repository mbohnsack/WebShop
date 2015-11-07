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
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        int prodID = Integer.parseInt(request.getParameter("loeschen"));

        DatabaseHelper db = new DatabaseHelper();
        db.deleteProduct(prodID);

        String url = "/MitarbeiterView/produktVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
    }
}
