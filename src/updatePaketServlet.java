import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Chris on 05.11.2015.
 */
@WebServlet("/updatePaketServlet")
public class updatePaketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String[] produkte = request.getParameterValues("produkte");
        List<Integer> prioList = new ArrayList<>();


        int paketid =  Integer.parseInt(request.getParameter("paketid"));
        int inhaltid =  Integer.parseInt(request.getParameter("inhaltid"));
        System.out.println(inhaltid +"inhaltID" );
        String paketname =  request.getParameter("paketname");
        String paketname2 = request.getParameter("paketname2");
        String paketbeschreibung = request.getParameter("paketbeschreibung");
        String details = request.getParameter("details");
        String kategorie = request.getParameter("kategorie");
        String hersteller = request.getParameter("hersteller");
        double preis = Double.parseDouble(request.getParameter("preis"));
        int anzahlMBuchungen = Integer.parseInt(request.getParameter("anzahlMBuchungen"));

        if(produkte!=null){
        for (String produktId : produkte) {
            Integer prio = Integer.parseInt(request.getParameter(produktId.substring(0, produktId.length() - 1)));
            prioList.add(prio);
        }
        }

        int i = produkte.length;
        int counter = 0;
        while (counter < i) {
            System.out.println(produkte[counter] + " " + prioList.get(counter));
            counter++;
        }

        DatabaseHelper db = new DatabaseHelper();

        try{

            //Paket als Produkt anlegen
            db.updateProduct(paketid, kategorie, hersteller, preis, paketbeschreibung, details, paketname, paketname2, anzahlMBuchungen);

            //Paketinhalte in die Pakettabelle schreiben
            int  anzahlProdukte = produkte.length;
            for(int counterP =0;counterP<anzahlProdukte;counterP++){
                db.deletePaketKomponenten(paketid);
                db.addPaket(paketid,kategorie,prioList.get(counterP),Integer.parseInt( produkte[counterP].substring(0, produkte[counterP].length() - 1)));


            }


        }catch (Exception e){
            e.printStackTrace();
        }

        String url = "/MitarbeiterView/paketeVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();

    }
}
