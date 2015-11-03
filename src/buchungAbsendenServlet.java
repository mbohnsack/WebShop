import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@WebServlet("/buchungAbsendenservelet")
public class buchungAbsendenServlet
        extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        DatabaseHelper db = new DatabaseHelper();



        String kundenmail = request.getParameter("email");

        

        String abholDatumString = request.getParameter("abholdatum");
        String abgabeDatumString = request.getParameter("abgabedatum");

        SimpleDateFormat sdf  = new SimpleDateFormat("dd.MM.yyyy");
        long abgabeDatumInMs = 0;
        long abholDatumInMs = 0;
        try{
            Date abgabedatumSDF = sdf.parse(abgabeDatumString);
            Date abholdatumSDF = sdf.parse(abholDatumString);
            abholDatumInMs = abholdatumSDF.getTime();
            abgabeDatumInMs = abgabedatumSDF.getTime();

        }catch(Exception e){
        }

        Date abholdatum = new Date(abholDatumInMs);
        Date abgabedatum = new Date(abgabeDatumInMs);
        List<Integer> produktids = new ArrayList<Integer>();
        produktids.add(1);

        Boolean suxxess = db.createBuchung(kundenmail, abholdatum, abgabedatum, produktids);
        System.out.println("erfolg:" + suxxess);

        db.disconnectDatabase();

        String url = "/index.jsp";
        response.sendRedirect(url);
    }
}