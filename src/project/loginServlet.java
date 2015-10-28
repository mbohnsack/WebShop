package project; /**
 * Created by Malte on 21.10.2015.
 */
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/project.loginServlet")
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
        if(targetPage.equals("MitarbeiterView/main.jsp")){
            login = db.loginMitarbeiter(user, pwd);
        } else if(targetPage.equals("")){
            login = db.loginKunde(user, pwd);
        }
        if (login == true) {
            SendMailSSL.sendMail();
            request.setAttribute("username", user);
            request.setAttribute("targetpage", targetPage);
            System.out.println("Test");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/general/setCookie.jsp");
            System.out.println("Test II");
            rd.forward(request,response);
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher(sourcePage);
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Either user name or password is wrong.</font>");
            rd.include(request, response);
        }
    }
}
