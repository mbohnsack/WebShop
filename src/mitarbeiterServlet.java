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
 * Created by wesley.rubio.cueva on 22.10.2015.
 */
@Deprecated
@WebServlet("/mitarbeiterServlet")
public class mitarbeiterServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        DatabaseHelper db = new DatabaseHelper();
        String name = request.getParameter("name");
        String passwort = request.getParameter("passwort");

        if(db.mitarbeiterFrei(name)){
            //db.createMitarbeiter(name, passwort);
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/mitarbeitererstellen.html"); //Das html-Dokument muss noch erstellt werden.
            PrintWriter out= response.getWriter();
            out.println("<font color=green>The process was succesfull.</font>");
            rd.include(request, response);        }
        else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/mitarbeitererstellen.html");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>The name does already exist.</font>");
            rd.include(request, response);

        }
        db.disconnectDatabase();
    }
}
