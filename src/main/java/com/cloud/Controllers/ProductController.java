package com.cloud.Controllers;

import com.cloud.Daos.ProductDao;
import com.cloud.Daos.UserDao;
import com.cloud.Models.Product;
import com.cloud.Models.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
@WebServlet("/pro/*")
public class ProductController extends HttpServlet {
    private ProductDao productDao;

    public void init() {
        productDao = new ProductDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action  = request.getPathInfo();
        switch (action)
        {
            case "/list_product" :
                System.out.println("list");
                listProduct(request, response);
                break;
            case "/dashboard" :
                System.out.println("list");
                dashboard(request, response);
                break;
            case "/insert_product":
                addProduct(request, response);
                break;
            case "/edit_product":
                showEditProduct(request, response);
                break;
            case "/update_product":
                updateProduct(request, response);
                break;
            case "/delete_product":
                try {
                    deleteProduct(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request, response);
                break;
        }

    }

    private void dashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Product> listProduct = productDao.getAllProducts();
        request.setAttribute("listProduct", listProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index_admin.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        int productID = Integer.parseInt(request.getParameter("ProductID"));
        productDao.deleteProduct(productID);
        response.sendRedirect("list_product");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        int productID = Integer.parseInt(request.getParameter("ProductID"));
        String Name = request.getParameter("Name");
        String DateAdd = request.getParameter("DateAdd");
        java.sql.Date dateAdd = java.sql.Date.valueOf(DateAdd);
        String Description =  request.getParameter("Description");
        String Price = request.getParameter("Price");
        BigDecimal price = new BigDecimal(Price);
        int Stock = Integer.parseInt(request.getParameter("Stock"));
        String encodedImage = request.getParameter("encodedImage");
        String base64Image = encodedImage.replaceAll("data:image/\\w+;base64,", "");
        byte[] imageBytes = Base64.getDecoder().decode(base64Image);
        int CategoryID = Integer.parseInt(request.getParameter("CategoryID"));
        String Rate = request.getParameter("Rate");
        BigDecimal rate = new BigDecimal(Rate);
        Product product = new Product(productID,Name,Description,price,Stock,imageBytes,dateAdd,CategoryID,rate);
        productDao.updateProduct(product);
        response.sendRedirect("list_product");
    }

    private void showEditProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int proID = Integer.parseInt(request.getParameter("ProductID"));
        Product curpro = productDao.selectProById(proID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/postDetails.jsp");
        request.setAttribute("Product", curpro);
        dispatcher.forward(request, response);

    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String Name = request.getParameter("Name");
        String DateAdd = request.getParameter("DateAdd");
        java.sql.Date dateAdd = java.sql.Date.valueOf(DateAdd);
        String Description =  request.getParameter("Description");
        String Price = request.getParameter("Price");
        BigDecimal price = new BigDecimal(Price);
        int Stock = Integer.parseInt(request.getParameter("Stock"));
        String encodedImage = request.getParameter("encodedImage");
        String base64Image = encodedImage.replaceAll("data:image/\\w+;base64,", "");
        byte[] imageBytes = Base64.getDecoder().decode(base64Image);
        int CategoryID = Integer.parseInt(request.getParameter("CategoryID"));
        String Rate = request.getParameter("Rate");
        BigDecimal rate = new BigDecimal(Rate);
        Product product = new Product(Name,Description,price,Stock,imageBytes,dateAdd,CategoryID,rate);
        productDao.addProduct(product);
        response.sendRedirect("list_product");
    }

    private void listProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> listProduct = productDao.getAllProducts();
        request.setAttribute("listProduct", listProduct);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/posts.jsp");
        dispatcher.forward(request, response);
    }
}
