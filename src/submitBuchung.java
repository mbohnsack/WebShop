import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Malte on 21.10.2015.
 */
@WebServlet("/submitBuchung")
public class submitBuchung {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        // code to process the form...
        DatabaseHelper db = new DatabaseHelper();
        String buchungen[] = request.getParameterValues("buchung");
        if (buchungen != null) {
            for (String lang : buchungen){
                    //db.submitBuchung(buchungen);
                }
        }
    }

}
