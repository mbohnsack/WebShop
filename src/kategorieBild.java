import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Malte on 09.11.2015.
 */
@WebServlet("/kategorieBild")
public class kategorieBild {
    //Ausgeben eines Bildes für die Nutzung in <img>
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        DatabaseHelper db = new DatabaseHelper();


        String name = request.getParameter("name");
        byte[] content = db.getBildKategorie(name);
        db.disconnectDatabase();

        response.setContentType("image/jpeg");
        response.setContentLength(content.length);
        response.getOutputStream().write(content);
    }
}
