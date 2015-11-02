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
@WebServlet("/updateKategorieServlet")
public class updateKategorieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String kategorieName = request.getParameter("kategorieName");
        String ueberKategorie = request.getParameter("ueberKategorie");
        String file = request.getParameter("file");

        DatabaseHelper db = new DatabaseHelper();
        db.updateKategorie(kategorieName,ueberKategorie);

        String url = "/MitarbeiterView/kategorieVerwalten.jsp";
        response.sendRedirect( url );
    }
}
