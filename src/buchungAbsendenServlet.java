import project.DatabaseHelper;
import project.cart;
import project.loginCookie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@WebServlet("/buchungAbsendenservelet")
public class buchungAbsendenServlet
        extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {


        DatabaseHelper db = new DatabaseHelper();
        String kundenmail = "";


        // den loginname des angemeldeten Nutzers auslesen
        String user = "";
        HttpSession session = request.getSession();
        loginCookie loginDaten = (loginCookie)
                session.getAttribute("loginCookie");
        if (loginDaten != null) {
            if (loginDaten.getRolle() == "Kunde") {
                user = loginDaten.getUsername();

                ResultSet rs = db.getKundenDatenByLogin(user);
                try{
                    kundenmail = rs.getString(12);
                }catch(SQLException e){}
            }
        }else{
            kundenmail = request.getParameter("email");
            //TODO abfragen für restliche felder
            //TODO createKunde
        }


        //TODO Datumsformat is nich konform...
        String abholDatumString = request.getParameter("abholdatum");
        String abgabeDatumString = request.getParameter("abgabedatum");

        SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd");
        Date abholdatum = null;
        Date abgabedatum = null;

        try{
            abholdatum = sdf.parse(abholDatumString);
            abgabedatum = sdf.parse(abgabeDatumString);


        }catch(Exception e){}



        cart shoppingCart;
        session = request.getSession();
        shoppingCart = (cart) session.getAttribute("cart");
        List<Integer> produktids = shoppingCart.getCartItems();

        Integer suxxess = db.createBuchung(kundenmail, abholdatum, abgabedatum, produktids);
        System.out.println("erfolg:" + suxxess);

        db.disconnectDatabase();

        String url = "/index.jsp";
        response.sendRedirect(url);
    }
}