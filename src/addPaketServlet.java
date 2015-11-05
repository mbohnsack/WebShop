import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Chris on 04.11.2015.
 */
@WebServlet("/addPaketServlet")
public class addPaketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

       // String[] produkte = request.getParameterValues("produkte");
        List<Integer> prioList = new ArrayList<>();

        String paketname =  request.getParameter("paketname");
        String paketname2 = request.getParameter("paketname2");
        String paketbeschreibung = request.getParameter("paketbeschreibung");
        String details = request.getParameter("details");
        String kategorie = request.getParameter("kategorie");
        String hersteller = request.getParameter("hersteller");
        double preis =  Double.parseDouble(request.getParameter("preis"));


/*
        for (String produktId : produkte) {
            Integer prio = Integer.parseInt(request.getParameter(produktId.substring(0, produktId.length() - 1)));
            prioList.add(prio);
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
            int prodid=db.addProduct(kategorie, hersteller, preis, paketbeschreibung, details, paketname, paketname2);

            //Paketinhalte in die Pakettabelle schreiben
            int  anzahlProdukte = produkte.length;
            for(int counterP =0;counterP<anzahlProdukte;counterP++){
                db.addPaket(prodid,kategorie,prioList.get(counterP),Integer.parseInt( produkte[counterP]));
            }


        }catch (Exception e){
            e.printStackTrace();
        }

        String url = "/MitarbeiterView/paketeVerwalten.jsp";
        response.sendRedirect( url );
        db.disconnectDatabase();
        */
    }
}
