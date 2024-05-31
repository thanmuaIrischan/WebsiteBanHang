package com.cloud.Controllers;

import com.cloud.DTOs.CartDetail;
import com.cloud.Daos.CartDao;
import com.cloud.Daos.ProductDao;
import com.cloud.Models.Cart;
import com.cloud.Models.Product;
import com.cloud.Models.Session;
import com.cloud.Models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private CartDao cartDao = null;
    private ProductDao productDao = null;
    @Override
    public void init() throws ServletException {
        cartDao = new CartDao();
        productDao = new ProductDao();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "add":
                addNewItemToCart(req, resp);
                break;
            case "update":
                updateItemQuantityInCart(req, resp);
                break;
            case "remove":
                removeItemInCart(req, resp);
                break;
            case "list":
                getAllItemsInCart(req, resp);
                break;
            default:
                break;
        }
    }

    protected void getAllItemsInCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //User user = (User) req.getSession(false).getAttribute("userLogin");
        int userID  = Session.userID;
        List<CartDetail> cartDetails = new ArrayList<>();
        List<Cart> carts = cartDao.findAll(userID);
        if (carts == null) {
            req.setAttribute("cartEmpty", "Your cart is empty");
        } else {
            for (Cart cart : carts) {
                CartDetail item = new CartDetail(cart, productDao.selectProById(cart.getProductID()));
                cartDetails.add(item);
            }
            req.setAttribute("cart", cartDetails);
        }

        req.getRequestDispatcher("user_cart.jsp").forward(req, resp);
    }
    protected void addNewItemToCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //User user = (User) req.getSession(false).getAttribute("userLogin");
        int userID  = Session.userID;
        int productid = Integer.parseInt(req.getParameter("productid"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        if (productDao.selectProById(productid).getStock() >= quantity) {
            Cart cart = new Cart();
            cart.setUserID(userID);
            cart.setProductID(productid);
            cart.setQuantity(quantity);
            int status = cartDao.create(cart);

            if (status > 0) {
                resp.setStatus(HttpServletResponse.SC_ACCEPTED);
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    protected void updateItemQuantityInCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cartid = Integer.parseInt(req.getParameter("cartid"));
        int productid = Integer.parseInt(req.getParameter("productid"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        if (productDao.selectProById(productid).getStock() >= quantity) {
            int status = cartDao.update(quantity, cartid);

            if (status > 0) {
                resp.setStatus(HttpServletResponse.SC_ACCEPTED);
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    protected void removeItemInCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cartid = Integer.parseInt(req.getParameter("cartid"));

        int status = cartDao.deleteByCartId(cartid);

        if (status > 0) {
            resp.setStatus(HttpServletResponse.SC_ACCEPTED);
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
