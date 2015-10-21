/**
 * Created by Malte on 21.10.2015.
 */
import javax.servlet.*;
@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        // code to process the form...
        String user = request.getParameter("username");
        String pwd = request.getParameter("password");
        DatabaseHelper db=new DatabaseHelper();
        if(db.login()==true){
            response.sendRedirect("index.html");
        }else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/test.html");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>Either user name or password is wrong.</font>");
            rd.include(request, response);
        }
    }
}
