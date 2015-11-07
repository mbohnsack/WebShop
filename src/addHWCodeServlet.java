import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Malte on 05.11.2015.
 */
@WebServlet("/addHWCodeServlet")
public class addHWCodeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String produkt=request.getParameter("produkt");
        String hwcode=request.getParameter("hwcode");
        int produktid=Integer.parseInt(produkt);
        DatabaseHelper db=new DatabaseHelper();
        db.addHWCode(produktid,hwcode);

        String url = "/MitarbeiterView/produktVerwalten.jsp";
        response.sendRedirect(url);
        db.disconnectDatabase();
    }
}
