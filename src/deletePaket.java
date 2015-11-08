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
@WebServlet("/deletePaket")
public class deletePaket extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        int pakID = Integer.parseInt(request.getParameter("loeschen"));

        DatabaseHelper db = new DatabaseHelper();
        db.deletePaket(pakID);

        String url = "/MitarbeiterView/paketeVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
    }
}