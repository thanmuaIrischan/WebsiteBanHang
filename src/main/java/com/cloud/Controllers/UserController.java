package com.cloud.Controllers;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
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

import com.cloud.Models.Session;
import com.cloud.Models.User;
import com.cloud.Daos.UserDao;
import com.mysql.cj.x.protobuf.MysqlxCrud;

@WebServlet("/user/*")

public class UserController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private  UserDao userDao;
    public void init()
    {
        userDao = new UserDao();
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
                case "/login":
                    loginUser(request, response);
                    break;
                case "/list_UserController" :
                    listUser(request, response);
                    break;
                case "/insert_UserController":
                    insertUser(request, response);
                    break;
                case "/edit_UserController":
                    showEditForm(request, response);
                    break;
                case "/update_UserController":
                    updateUser(request, response);
                    break;
                case "/delete_UserController":
                    deleteUser(request, response);
                    break;
                case "/updatePasswordProfile_UserController":
                    updatePasswordProfile(request, response);
                    break;
                case "/checkOldPassword_UserController":
                    checkOldPassword(request, response);
                    break;
                case "logout_UserController":
                    logout(request, response);
                    break;
                default:
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    private void listUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List < User > listUser = userDao.getAllUsers();
        request.setAttribute("listUser", listUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/users.jsp");
        dispatcher.forward(request, response);
    }
    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        String FullName = request.getParameter("FullName");
        String birthDateString = request.getParameter("BirthDate");
        java.sql.Date birthDate = java.sql.Date.valueOf(birthDateString);
        String Address =  request.getParameter("Address");
        String Phone = request.getParameter("Phone");
        String Email = request.getParameter("Email");
        String Password = request.getParameter("Password");
        String Role = request.getParameter("Role");
        String encodedImage = request.getParameter("encodedImage");
        String base64Image = encodedImage.replaceAll("data:image/\\w+;base64,", "");
        byte[] imageBytes = Base64.getDecoder().decode(base64Image);
        User user = new User(FullName,birthDate,Address, Phone, Email,Password,Role);
        user.setAvatar(imageBytes);
        userDao.insertUser(user);
        String from = request.getParameter("from");
        if ("signup".equals(from)) {
            request.setAttribute("email",Email);
            request.setAttribute("password",Password);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            try{
                dispatcher.forward(request, response);
            }catch (ServletException e) {
                e.printStackTrace();
            }
        } else if ("users".equals(from)) {
            response.sendRedirect("list_UserController");
        }
    }
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int UserID = Integer.parseInt(request.getParameter("UserID"));
        userDao.deleteUser(UserID);
        response.sendRedirect("list_UserController");
    }
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String Email = request.getParameter("email");
        String Password = request.getParameter("password");
        User user = new User();
        user.setEmail(Email);
        user.setPassword(Password);
        int id = userDao.loginUser(user);
        if(id != -1)
        {
            user = userDao.selectUserById(id);
            Session.userID = user.getUserID();
            Session.fullName = user.getFullName();
            Session.email = user.getEmail();
            Session.password = user.getPassword();
            Session.role = user.getRole();
            Session.avatar = user.getAvatar();
            if(user.getRole().equals("Manager") || user.getRole().equals("manager"))
                response.sendRedirect(request.getContextPath() + "/pro/dashboard");
            else
                response.sendRedirect(request.getContextPath()+"/home");
        }
        else {
            request.setAttribute("errMsg", "Email or Password is incorrect");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            try{
                dispatcher.forward(request, response);
            }catch (ServletException e) {
                e.printStackTrace();
            }
        }
    }


    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("UserID"));
        User existuser = userDao.selectUserById(userID );
        RequestDispatcher dispatcher = request.getRequestDispatcher("/usersDetails.jsp");
        request.setAttribute("User", existuser);
        if(existuser.getAvatar()!=null)
        {
            String encodedImage = Base64.getEncoder().encodeToString(existuser.getAvatar());
            request.setAttribute("encodedImage", encodedImage);
        }
        dispatcher.forward(request, response);
    }
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        int userID = Integer.parseInt(request.getParameter("UserID"));
        String FullName = request.getParameter("FullName");
        String birthDateString = request.getParameter("BirthDate");
        java.sql.Date birthDate = java.sql.Date.valueOf(birthDateString);
        String Address =  request.getParameter("Address");
        String Phone = request.getParameter("Phone");
        String Email = request.getParameter("Email");
        String Password = request.getParameter("Password");
        String Role = request.getParameter("Role");
        String encodedImage = request.getParameter("encodedImage");
        String base64Image = encodedImage.replaceAll("data:image/\\w+;base64,", "");
        byte[] imageBytes = Base64.getDecoder().decode(base64Image);
        User updateuser = new User( userID ,FullName, birthDate,Address, Phone, Email,Password,Role);
        updateuser.setAvatar(imageBytes);
        userDao.updateUser(updateuser);
        User user = userDao.selectUserById(userID);
        request.setAttribute("userLogin", user);
        Session.userID = user.getUserID();
        String from = request.getParameter("from");
        if ("profile".equals(from)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
            try{
                dispatcher.forward(request, response);
            }catch (ServletException e) {
                e.printStackTrace();
            }
        } else if ("userDetails".equals(from)) {
            response.sendRedirect("list_UserController");
        }
    }
    private void updatePasswordProfile(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String encodedNewPassword = request.getParameter("newPassword");
        String encodedUserID = request.getParameter("userID");

        String newPassword = new String(Base64.getDecoder().decode(encodedNewPassword));
        int userID = Integer.parseInt(new String(Base64.getDecoder().decode(encodedUserID)));
        request.setCharacterEncoding("UTF-8");
        User updateuser = new User();
        updateuser.setUserID(userID);
        updateuser.setPassword(newPassword);
        String resultMsg ="";
        if(userDao.updateUserPassword(updateuser))
            resultMsg = "Update password succeed";
        else
            resultMsg = "Update password fail";
        User user = userDao.selectUserById(userID);

        request.setAttribute("userLogin", user);
        Session.userID = user.getUserID();
        request.setAttribute("resultMsg",resultMsg);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
        try{
            dispatcher.forward(request, response);
        }catch (ServletException e) {
            e.printStackTrace();
        }
    }
    private void checkOldPassword(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String newPassword = request.getParameter("oldPassword");
        int userID = Integer.parseInt(request.getParameter("userID"));
        request.setCharacterEncoding("UTF-8");
        User updateuser = new User();
        updateuser.setUserID(userID);
        updateuser.setPassword(newPassword);
        boolean isPasswordValid = userDao.checkUserOldPassword(updateuser);
        if (isPasswordValid) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    private void logout(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession(false);
        Session.userID = -1;
        Session.fullName =null;
        Session.email = null;
        Session.password = null;
        Session.role = null;
        Session.avatar = null;
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
