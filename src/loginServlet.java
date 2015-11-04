/**
 * Created by Malte on 21.10.2015.
 */

import project.DatabaseHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        // code to process the form...
        String user = request.getParameter("username");
        String pwd = request.getParameter("password");
        String targetPage = request.getParameter("targetpage");
        String sourcePage = request.getParameter("sourcepage");

        Boolean login = false;
        DatabaseHelper db = new DatabaseHelper();
        if (targetPage.equals("MitarbeiterView/main.jsp")) {
            login = db.loginMitarbeiter(user, pwd);
        } else if (targetPage.equals("index.jsp")) {
            login = db.loginKunde(user, pwd);
        }
        if (login == true) {
            request.setAttribute("username", user);
            request.setAttribute("targetpage", targetPage);
            System.out.println("user:" + user + " target:" + targetPage + " login:" + login);

            RequestDispatcher rd = getServletContext().getRequestDispatcher("/general/setCookie.jsp");
            System.out.println("Test II");
            rd.forward(request, response);

        } else {
            if (sourcePage.contentEquals("/loginKunde.jsp")){
                //textausgabe im formular
                request.setAttribute("message", "Passwort und Login stimmten nicht &uuml;berein.");
                request.getRequestDispatcher("/loginKunde.jsp").forward(request, response);

            }else{
                RequestDispatcher rd = getServletContext().getRequestDispatcher(sourcePage);
                PrintWriter out = response.getWriter();
                out.println("<font color=red>Either user name or password is wrong.</font>");
                rd.include(request, response);
            }


        }
        db.disconnectDatabase();
    }
}
