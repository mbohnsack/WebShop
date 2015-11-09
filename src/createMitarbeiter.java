import project.DatabaseHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Malte on 30.10.2015.
 */
@WebServlet("/createMitarbeiter")
public class createMitarbeiter extends HttpServlet {
    //Neuen Mitarbeiter oder Admin anlegen
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        DatabaseHelper db=new DatabaseHelper();
        String user=request.getParameter("user");
        String pwd=request.getParameter("password");
        String typ=request.getParameter("typ");
        if(db.mitarbeiterFrei(user)) {
            db.createMitarbeiter(user, pwd, typ);
            response.sendRedirect("/MitarbeiterView/mitarbeiterVerwalten.jsp");
        }else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/MitarbeiterView/mitarbeiterAnlegen.jsp");
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Mitarbeiter konnte nict erstellt werden, da der Name bereits vergeben ist..</font>");
            rd.include(request, response);
        }
        db.disconnectDatabase();
    }
}
