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
    //Daten eines Pateket �ndern/Updaten (inkl Inhalte)
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String[] anzahl = request.getParameterValues("anzahl");
        String[] produkte = request.getParameterValues("produkte");
        List<Integer> prioList = new ArrayList<>();


        int paketid =  Integer.parseInt(request.getParameter("paketid"));
        int inhaltid =  Integer.parseInt(request.getParameter("inhaltid"));
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
                System.out.println(produktId);
                Integer prio = Integer.parseInt(request.getParameter(produktId.substring(0, produktId.length() - 1)));
                prioList.add(prio);
            }

            DatabaseHelper db = new DatabaseHelper();

            try{
                //BlaBla
                //Paket als Produkt anlegen
                db.updateProduct(paketid, kategorie, hersteller, preis, paketbeschreibung, details, paketname, paketname2, anzahlMBuchungen);

                //Paketinhalte in die Pakettabelle schreiben
                int  anzahlProdukte = produkte.length;

                db.deletePaketKomponenten(paketid);
                int counterP=0;
                while(counterP<anzahlProdukte){
                    for(int counter =0;counter<anzahlProdukte;counter++) {
                        int anzahlInt = Integer.parseInt(anzahl[counter]);
                        System.out.println(anzahlInt+ "anzahl");
                        for (int i2 = 0; i2 < anzahlInt; i2++) {
                            db.addPaket(paketid, kategorie, prioList.get(counterP), Integer.parseInt(produkte[counterP].substring(0, produkte[counterP].length() - 1)));

                        }
                    }
                    //db.addPaket(paketid,kategorie,prioList.get(counterP),Integer.parseInt( produkte[counterP].substring(0, produkte[counterP].length() - 1)));
                    counterP++;
                }

                db.disconnectDatabase();
            }catch (Exception e){
                e.printStackTrace();
            }
            String url = "/MitarbeiterView/paketeVerwalten.jsp";
            response.sendRedirect( url );
        }








    }
}
