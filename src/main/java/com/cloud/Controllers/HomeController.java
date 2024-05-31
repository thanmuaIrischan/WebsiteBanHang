package com.cloud.Controllers;

import com.cloud.Daos.ProductDao;
import com.cloud.Daos.SaleDao;
import com.cloud.Dto.ProductDto;
import com.cloud.Models.Product;
import com.cloud.Models.Sale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    //Page path
    private String USER_HOME_PAGE = "index.jsp";
    private String ADMIN_DASHBOARD = "index_admin.jsp";
    private String USER_ABOUT_PAGE = "home_about.jsp";
    private String ALL_PRODUCT_PAGE = "all_product.jsp";
    private String NEW_ARRIVAL_PRODUCT_PAGE = "new_arrival.jsp";
    private String ON_HOT_PRODUCT_PAGE = "popular_product.jsp";
    // DAO
    private ProductDao productDao;
    private SaleDao saleDao;
    public void init(){
        productDao = new ProductDao();
        saleDao = new SaleDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = "";
        String action = req.getParameter("action");
        String search = req.getParameter("search");
        if(action == null){
            List<Product> productList = productDao.getAllProductsRandomly(10);
            List<ProductDto> productDtoList = productList.stream().map(data -> {
                Sale sale = null;
                sale = saleDao.searchSaleProduct(data.getProductID());
                return ProductDto.builder()
                        .productID(data.getProductID())
                        .price(data.getPrice())
                        .stock(data.getStock())
                        .description(data.getDescription())
                        .image(data.getImage())
                        .name(data.getName())
                        .discount(sale.getDiscountPercent())
                        .build();
            }).collect(Collectors.toList());
            req.setAttribute("listProduct", productDtoList);
            url = USER_HOME_PAGE;

        }else{
            List<Product> productList = null;
            if(search == null){
                switch (action){
                    case "about":
                        url = USER_ABOUT_PAGE;
                        productList = new ArrayList<>();
                        break;
                    case "all":
                        url = ALL_PRODUCT_PAGE;
                        productList = productDao.getAllProducts();
                        break;
                    case "new-arrival":
                        url = NEW_ARRIVAL_PRODUCT_PAGE;
                        productList = productDao.getAllNewProductOnWeek();
                        break;
                    case "hot":
                        url = ON_HOT_PRODUCT_PAGE;
                        productList = productDao.getAllProductOnPopular(20);
                        break;
                    default:
                        url = USER_HOME_PAGE;
                        productList = productDao.getAllProductsRandomly(10);
                        break;
                }
            }else {
                switch (action){
                    case "about":
                        url = USER_ABOUT_PAGE;
                        productList = new ArrayList<>();
                        break;
                    case "all":
                        url = ALL_PRODUCT_PAGE;
                        productList = productDao.getAllProducts(search);
                        break;
                    case "new-arrival":
                        url = NEW_ARRIVAL_PRODUCT_PAGE;
                        productList = productDao.getAllNewProductOnWeek(search);
                        break;
                    case "hot":
                        url = ON_HOT_PRODUCT_PAGE;
                        productList = productDao.getAllProductOnPopular(20, search);
                        break;
                    default:
                        url = USER_HOME_PAGE;
                        productList = productDao.getAllProductsRandomly(10);
                        break;
                }
                req.setAttribute("searchValue", search);
            }

            List<ProductDto> productDtoList = productList.stream().map(data -> {
                Sale sale = null;
                sale = saleDao.searchSaleProduct(data.getProductID());
                return ProductDto.builder()
                        .productID(data.getProductID())
                        .price(data.getPrice())
                        .stock(data.getStock())
                        .description(data.getDescription())
                        .image(data.getImage())
                        .name(data.getName())
                        .discount(sale.getDiscountPercent())
                        .build();
            }).collect(Collectors.toList());
            req.setAttribute("listProduct", productDtoList);
        }
        req.getRequestDispatcher(url).forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
