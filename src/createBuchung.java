import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Malte on 28.10.2015.
 */
@WebServlet("/createBuchung")
public class createBuchung {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException, ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String abholungTemp=request.getParameter("abholung");
        String abgabeTemp=request.getParameter("abgabe");
        int product=Integer.parseInt(request.getParameter("product"));
        Date abholung = format.parse(abholungTemp);
        Date abgabe = format.parse(abgabeTemp);
        DatabaseHelper db=new DatabaseHelper();
        //db.createBuchung();

    }
}
