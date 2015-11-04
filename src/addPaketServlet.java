import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        String[] produkte =request.getParameterValues("produkte");
        List<Integer> prioList = new ArrayList<>();

        for(String produktId : produkte ){

             Integer prio = Integer.parseInt(request.getParameter(produktId.substring(0, produktId.length() - 1)));
             prioList.add(prio);
        }

        int i = produkte.length;
        int counter = 0;
        while(counter<i){
            System.out.println(produkte[counter]+ " " + prioList.get(counter));
            counter++;
        }
    }
}
