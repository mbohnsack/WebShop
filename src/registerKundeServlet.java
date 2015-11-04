import project.DatabaseHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;

/**
 * Created by filip on 02.11.2015.
 */

@WebServlet("/registerKundeServlet")
public class registerKundeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        System.out.println("TEST MAN");
        String benutzername = request.getParameter("benutzername");
        String nname = request.getParameter("nname");
        String vname = request.getParameter("vname");
        String email = request.getParameter("email");
        String strasse = request.getParameter("strasse");
        String hausnr = request.getParameter("hausnr");
        int plz = Integer.parseInt(request.getParameter("plz"));
        String ort = request.getParameter("ort");
        int telefon = Integer.parseInt(request.getParameter("telefon"));
        int mobil = Integer.parseInt(request.getParameter("mobil"));
        String passwort = request.getParameter("passwort");
        String passwortwd = request.getParameter("passwortwd");

        DatabaseHelper db = new DatabaseHelper();
        if(!db.mitarbeiterFrei(benutzername)) {
            //JOptionPane.showMessageDialog(null, "Benutzername bereits vergeben!");
            System.out.println("benutzer vergeben");
        } else if (passwort != passwortwd) {
            //JOptionPane.showMessageDialog(null, "Passwörter stimmen nicht überein!");
            System.out.println("passwort stimmt nicht überein");
        } else if (db.mitarbeiterFrei(benutzername)) {
            db.createKunde(benutzername, passwort, nname, vname, strasse, hausnr, plz, ort, telefon, mobil, email);
            //JOptionPane.showMessageDialog(null, "Success");
            System.out.println("success");
        }

        String url = "/register.jsp";
        response.sendRedirect(url);


        db.disconnectDatabase();
    }


}
