package project;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by Matzef on 03.11.2015.
 */
public class cart {

    int id;
    List<Integer> cartInhalt = new ArrayList<Integer>();

    public void clearCart(){
        cartInhalt.clear();
    }

    public List getCartItems() {
        return cartInhalt;
    }

    public void addToCart(int id) {
        cartInhalt.add(id);
    }

    public void removeItem(int index){
        cartInhalt.remove(index);
        System.out.println("removed index: "+ index);
    }
}
