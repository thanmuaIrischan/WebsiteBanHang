package com.cloud.Controllers;

import com.cloud.Daos.*;
import com.cloud.Models.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    private CartDao cartDao = null;
    private OrderDao orderDao = null;
    private OrderDetailDao orderDetailDao = null;
    private ProductDao productDao = null;
    private InvoiceDao invoiceDao = null;

    @Override
    public void init() throws ServletException {
        cartDao = new CartDao();
        orderDao = new OrderDao();
        orderDetailDao = new OrderDetailDao();
        productDao = new ProductDao();
        invoiceDao = new InvoiceDao();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "new":
                createNewOrder(req, resp);
                break;
            default:
                break;
        }
    }

    protected void createNewOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //User user = (User) req.getSession(false).getAttribute("userLogin");
        int userId = Session.userID;
        int typePayment = Integer.parseInt(req.getParameter("typepayment"));
        double total = Double.parseDouble(req.getParameter("amount"));

        List<Cart> cart = cartDao.findAll(userId);

        boolean isReadyToOrder = true;
        for (Cart item : cart) {
            if (productDao.selectProById(item.getProductID()).getStock() < item.getQuantity()) {
                isReadyToOrder = false;
            }
        }
        if (isReadyToOrder) {
            int orderid = orderDao.create(userId);
            orderDetailDao.create(orderid, cart);
            for (Cart item : cart) {
                Product product = productDao.selectProById(item.getProductID());
                product.setStock(product.getStock() - item.getQuantity());
                productDao.updateProduct(product);
            }

            Invoice invoice = new Invoice();
            invoice.setTotal(total);
            invoice.setOrderID(orderid);
            invoice.setTypePayment(typePayment); //COD == 0; VNPAY == 1
            invoice.setStatus(typePayment == 0 ? 0 : 1);

            invoiceDao.insertInvoice(invoice);

            cartDao.deleteByUserId(userId);
        }

        if (isReadyToOrder) {
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
