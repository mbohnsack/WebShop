import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Chris on 28.10.2015.
 */
@WebServlet("/addProduktServlet")
public class addProduktServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pwd = request.getParameter("password");
    }
}
