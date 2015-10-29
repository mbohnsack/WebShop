import project.DatabaseHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Chris on 28.10.2015.
 */
@WebServlet("/addProduktServlet")
public class addProduktServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        int produktid = Integer.parseInt(request.getParameter("produktid"));
        String produktname = request.getParameter("produktname");
        String produktname2 = request.getParameter("produktname2");
        String produktbeschreibung = request.getParameter("produktbeschreibung");
        String details = request.getParameter("details");
        String kategorie = request.getParameter("kategorie");
        String hersteller = request.getParameter("hersteller");
        double preis =  Double.parseDouble(request.getParameter("preis"));
        int anzahlMBuchungen = Integer.parseInt(request.getParameter("anzahlMBuchungen"));
        String file = request.getParameter("file");

        DatabaseHelper db = new DatabaseHelper();
        db.updateProduct(produktid,kategorie,hersteller,preis,produktbeschreibung,details,produktname,produktname2,anzahlMBuchungen);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/MitarbeiterView/produktVerwalten.jsp");
        PrintWriter out = response.getWriter();
        rd.include(request, response);
    }
}
