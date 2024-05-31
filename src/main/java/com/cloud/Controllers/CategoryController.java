package com.cloud.Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cloud.Models.*;
import com.cloud.Daos.*;
import com.mysql.cj.x.protobuf.MysqlxCrud;

@WebServlet("/category/*")
public class CategoryController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private CategoryDao categoryDao;

    public void init()
    {
        categoryDao = new CategoryDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action  = request.getPathInfo();
        try {
            switch (action)
            {
                case "/list_Category" :
                    ListCategory(request, response);
                    break;
                case "/ShowFormEdit_Categories":
                    ShowCategoriesDetails(request, response);
                    break;
                case "/update_Category":
                    Update_Category(request, response);
                    break;
                case "/delete_Categories":
                    Delete_Category(request, response);
                    break;
                case "/Insert_Categories":
                    Insert_Categories(request, response);
                    break;

                default:
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/categories.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    private void ListCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        //HttpSession session = request.getSession();
        List<Category> listcategory = categoryDao.getAllCategory();
        request.setAttribute("listcategory", listcategory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/categories.jsp");
        dispatcher.forward(request, response);
    }

    private void ShowCategoriesDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int CategoryID = 1;
        try {
            CategoryID = Integer.parseInt(request.getParameter("CategoryID"));
        } catch (NumberFormatException e) {
            CategoryID = 1;
        }
        Category categoryexist = categoryDao.selectCategoryByID(CategoryID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/categoriesDetails.jsp");

        request.setAttribute("category", categoryexist);
        dispatcher.forward(request, response);
    }

    private void Update_Category(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int CategoryID = Integer.parseInt(request.getParameter("CategoryID"));
        String CategoryName = request.getParameter("CategoryName");
        String DateAddString = request.getParameter("DateAdd");
        java.sql.Date DateAdd = java.sql.Date.valueOf(DateAddString);

        Category category = new Category(CategoryID , CategoryName, DateAdd );
        //HttpSession session = request.getSession();
        request.setAttribute("category", category);
        categoryDao.updateCategory(category);
        List<Category> listcategory = categoryDao.getAllCategory();
        request.setAttribute("listcategory", listcategory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/categories.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
    private void Delete_Category(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int CategoryID = Integer.parseInt(request.getParameter("CategoryID"));
        try {
            categoryDao.Delete_Category(CategoryID);
        }catch (SQLException ex)
        {
        }
        //HttpSession session = request.getSession();
        List<Category> listcategory = categoryDao.getAllCategory();
        request.setAttribute("listcategory", listcategory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/categories.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private void Insert_Categories(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        String CategoryName = request.getParameter("CategoryName");
        String DateAddString = request.getParameter("DateAdd");
        java.sql.Date DateAdd = java.sql.Date.valueOf(DateAddString);
        Category category = new Category(CategoryName, DateAdd);
        categoryDao.Insert_Category(category);
        //HttpSession session = request.getSession();
        List<Category> listcategory = categoryDao.getAllCategory();
        request.setAttribute("listcategory", listcategory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/categories.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }


}
