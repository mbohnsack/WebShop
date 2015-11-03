import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
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

        String kundenmail="";

        // gucken ob ein KD angemeldet ist sonnst email ausm formular
        String cookieName = "LoginCookie";
        Cookie cookies [] = request.getCookies ();
        Cookie myCookie = null;
        if (cookies != null)
        {
            for (int i = 0; i < cookies.length; i++)
            {
                if (cookies [i].getName().equals (cookieName))
                {
                    myCookie = cookies[i];
                    break;
                }
            }
        }
        String user = myCookie.getValue();

        if(myCookie!=null){
            ResultSet kundenMailabfragen = db.getKundenDatenByLogin(user);
            try{
                while(kundenMailabfragen.next()){
                    kundenmail = kundenMailabfragen.getString(12);
                    System.out.println(kundenmail);
                }

            }catch(SQLException e){

            }
        }else{
            kundenmail = request.getParameter("email");
        }
        

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