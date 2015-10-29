import project.DatabaseHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Malte on 28.10.2015.
 */
@WebServlet("/createBuchung")
public class createBuchung extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        DatabaseHelper db = new DatabaseHelper();
        String[] produkte=request.getParameterValues("produkte");
        List<Integer> products=new ArrayList<Integer>();
        if(produkte!=null) {
            for (String produkt : produkte) {
                products.add(Integer.parseInt(produkt.substring(0,produkt.length()-1)));
            }
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String abholungTemp = request.getParameter("abholung");
        String abgabeTemp = request.getParameter("abgabe");
        Date abholung = null;
        try {
            abholung = format.parse(abholungTemp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Date abgabe = null;
        try {
            abgabe = format.parse(abgabeTemp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if(request.getParameter("submit").equals("Buchen")) {
            //db.createBuchung();
        }else{
            List<String> verfuegbareProdukte=new ArrayList<String>();
            double gesamtpreis=0;
            if(products!=null) {
                for (int product:products){
                    Double preisTemp = db.getPrice(product);
                    gesamtpreis+=((abgabe.getTime()-abholung.getTime())/1000/3600/24)*preisTemp;
                    if(db.produktVerfuegbar(product, abholung, abgabe)){
                        verfuegbareProdukte.add("Das Produkt " + db.getBezeichnung(product)+" ist verfügbar.");
                    }else{
                        verfuegbareProdukte.add("Das Produkt " + db.getBezeichnung(product)+" ist nicht verfügbar.");
                    }
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/MitarbeiterView/buchungAnlegen");
                PrintWriter out = response.getWriter();
                for(int i=0;i<verfuegbareProdukte.size();i++){
                    out.println("<font color=red>"+verfuegbareProdukte.get(i)+"</font><br/>");
                }
                out.println("<font color=red>Der Preis beträgt "+gesamtpreis+"€.</font>");
                rd.include(request, response);
            }
        }
    }
}
