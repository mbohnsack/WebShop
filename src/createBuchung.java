import project.DatabaseHelper;
import project.SendMailSSL;

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
    //Erstellen einer neuen Buchung, inkl. senden einer Erfassungsmail
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        DatabaseHelper db = new DatabaseHelper();
        String[] produkte=request.getParameterValues("produkte");
        List<Integer> products=new ArrayList<Integer>();
        if(produkte!=null) {
            for (String produkt : produkte) {
                products.add(Integer.parseInt(produkt));
            }
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String abholungTemp = request.getParameter("abholung");
        String abgabeTemp = request.getParameter("abgabe");
        Date abholung = null;
        String mail=request.getParameter("kunde");
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
            Integer success = null;
            success=db.createBuchung(mail, abholung, abgabe, products);
            if(success>0){
                SendMailSSL.sendBuchungMail(mail, success);
                response.sendRedirect("/MitarbeiterView/buchungsVerwaltung.jsp");
            }else{
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/MitarbeiterView/buchungAnlegen.jsp");
                PrintWriter out = response.getWriter();
                out.println("<font color=red>Buchung konnte nicht erstellt werden. Pr�fen sie, ob der Kunde existiert und die Produkte vef�gbar sind.</font>");
                rd.include(request, response);
            }

        }else{
            List<String> verfuegbareProdukte=new ArrayList<String>();
            double gesamtpreis=0;
            if(products!=null) {
                for (int product:products){
                    Double preisTemp = db.getPrice(product);
                    gesamtpreis+=((((abgabe.getTime()-abholung.getTime())/1000/3600/24)-1)*preisTemp)*0.8+preisTemp;
                    if(db.produktVerfuegbar(product, abholung, abgabe)){
                        verfuegbareProdukte.add("Das Produkt " + db.getBezeichnung(product)+" ist verf�gbar.");
                    }else{
                        verfuegbareProdukte.add("Das Produkt " + db.getBezeichnung(product)+" ist nicht verf�gbar.");
                    }
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/MitarbeiterView/buchungAnlegen.jsp");
                PrintWriter out = response.getWriter();
                for(int i=0;i<verfuegbareProdukte.size();i++){
                    out.println("<font color=red>"+verfuegbareProdukte.get(i)+"</font><br/>");
                }
                out.println("<font color=red>Der Preis (ohne Kundenrabatte) betr�gt "+gesamtpreis+"�.</font>");
                rd.include(request, response);
            }
        }
        db.disconnectDatabase();
    }
}
