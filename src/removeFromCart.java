import project.cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet("/removeFromCart")
public class removeFromCart extends HttpServlet {


    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String sourcePage = request.getParameter("sourcepage");
        String pIDstring = request.getParameter("produktID");

        int pID = Integer.parseInt(pIDstring);
        System.out.println(pID + " to remove");

        cart shoppingCart;
        HttpSession session = request.getSession();
        shoppingCart = (cart) session.getAttribute("cart");
        if (shoppingCart == null) {
            shoppingCart = new cart();
            session.setAttribute("cart", shoppingCart);
        }
        shoppingCart.removeItem(pID);
        session.setAttribute("cart", shoppingCart);

        List<Integer> aktuellerInhalt = shoppingCart.getCartItems();
        System.out.println(aktuellerInhalt.size());

        response.sendRedirect(sourcePage);
    }
}
