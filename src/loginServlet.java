/**
 * Created by Malte on 21.10.2015.
 */
import javax.servlet.*;
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
        Boolean login = false;
        DatabaseHelper db = new DatabaseHelper();
        if(targetPage.equals("main.jsp")){
            login = db.loginMitarbeiter(user, pwd);
        } else if(targetPage.equals("")){
            login = db.loginKunde(user, pwd);
        }
        if (login == true) {
            response.sendRedirect(targetPage);
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/test.html");
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Either user name or password is wrong.</font>");
            rd.include(request, response);
        }
    }
}
