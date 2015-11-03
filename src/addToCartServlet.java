import project.DatabaseHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/addToCartServlet")
public class addToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String pIDstring = request.getParameter("produktID");
        int pID = Integer.parseInt(pIDstring);


        DatabaseHelper db = new DatabaseHelper();
        ResultSet produktDaten = db.getProductsById(pID);

        class bestellItem{
            int pNummer;
            int pAnzahl;
            public String pName;
            double pPreis;

            bestellItem(int anzahl, String name, double preis, int nummer){
                pAnzahl = anzahl;
                pName = name;
                pPreis = pAnzahl * preis;
                pNummer = nummer;
            }

            public void setpAnzahl(int anzahl){
                pAnzahl = anzahl;
            }
            public void setpName(String name){
                pName = name;
            }
            public void setpPreis(double preis){
                pPreis = pAnzahl * preis;
            }
            public int getpAnzahl(){return pAnzahl;
            }
            public String getpName(){return pName;
            }
            public double getpPreis(){return pPreis;
            }
            public double getpNummer(){return pNummer;
            }
        }

        bestellItem bi = new bestellItem(0,null,0, pID);

        try{
            while(produktDaten.next()) {
                bi.setpName(produktDaten.getString(3));
                bi.setpAnzahl(bi.getpAnzahl() + 1);
                bi.setpPreis(Double.parseDouble(produktDaten.getString(4)));
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }


        List<bestellItem> bestellListe = new ArrayList<bestellItem>();
        bestellListe.add(bi);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("navigation_right.jsp");
        request.setAttribute("bestellListe",bestellListe);
        rd.forward(request, response);
        db.disconnectDatabase();
    }
}
