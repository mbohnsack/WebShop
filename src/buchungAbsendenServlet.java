import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@WebServlet("/buchungAbsendenservelet")
public class buchungAbsendenServlet
        extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        DatabaseHelper db = new DatabaseHelper();

        String kundenmail = "mf.entwickelt@firemail.de";
        Date abholdatum = new Date(10000000);
        Date abgabedatum = new Date(12000000);
        List<Integer> produktids = new ArrayList<Integer>();
        produktids.add(1);




        Boolean suxxess = db.createBuchung(kundenmail, abholdatum, abgabedatum, produktids);
        System.out.println(suxxess);

        db.disconnectDatabase();
    }
}