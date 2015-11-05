import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by wesley.rubio.cueva on 05.11.2015.
 */
@WebServlet("/produktBild")
public class produktBild extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        //DatabaseHelper db = new DatabaseHelper();

        DatabaseHelper db = (DatabaseHelper)request.getAttribute("db");

        String id = request.getParameter("prodid");
        String number = request.getParameter("number");
        Integer prodid = Integer.parseInt(id);
        System.out.println(number);
        Integer number1 = Integer.parseInt(number);
        byte[] content = db.getBildProdukt(prodid, number1);
        //db.disconnectDatabase();

        response.setContentType("image/jpeg");
        response.setContentLength(content.length);
        response.getOutputStream().write(content);


    }
}
