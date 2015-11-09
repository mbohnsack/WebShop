import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Malte on 21.10.2015.
 */
@Deprecated
@WebServlet("/submitBuchung")
public class submitBuchung {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        DatabaseHelper db = new DatabaseHelper();
        String buchungen[] = request.getParameterValues("buchung");
        if (buchungen != null) {
            for (String buchung : buchungen){
                    db.submitBuchung(buchung);
                }
        }
        db.disconnectDatabase();
    }

}
