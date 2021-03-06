import project.cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/addToCartServlet")
public class addToCartServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String sourcePage = request.getParameter("sourcepage");
        String pIDstring = request.getParameter("produktID");
        int pID = Integer.parseInt(pIDstring);

        cart shoppingCart;
        HttpSession session = request.getSession();
        shoppingCart = (cart) session.getAttribute("cart");
        if (shoppingCart == null) {
            shoppingCart = new cart();
            session.setAttribute("cart", shoppingCart);
        }
        shoppingCart.addToCart(pID);
        session.setAttribute("cart", shoppingCart);

        response.sendRedirect(sourcePage);
    }
}
