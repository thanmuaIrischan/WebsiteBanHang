package com.cloud.Daos;

import com.cloud.Models.User;
import com.cloud.Util.JDBCUtil  ;
import com.cloud.Util.HandleExeption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    String sqlInsert = "INSERT INTO Users (FullName, BirthDate, Address, Phone, Email, Password, Role, Avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    String sqlGetAll = "SELECT * FROM Users";
    String sqlUpdate = "UPDATE Users SET FullName = N?, BirthDate = ?, Address = N?, Phone = ?, Email = ?, Role = ?, Avatar = ? WHERE UserID = ?";
    String DELETE_User_By_UserID = "DELETE FROM Users WHERE UserID = ?";
    String Select_User_By_UserID = "SELECT * FROM Users WHERE UserID = ?";
    String sqlLogin = "SELECT UserID FROM Users WHERE Email = ? and password = ?";
    public List<User> getAllUsers () {
        List<User> users = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetAll);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setBirthDate(rs.getDate("BirthDate"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setEmail(rs.getString("Email"));
                user.setRole(rs.getString("Role"));
                users.add(user);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return users;
    }
    public boolean insertUser(User user) {
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlInsert);
            ps.setString(1, user.getFullName());
            ps.setDate(2, new java.sql.Date(user.getBirthDate().getTime()));
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getRole());
            ps.setBytes(8, user.getAvatar());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new user was inserted successfully!");
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
            return false;
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return true;
    }
    public boolean updateUser(User user) throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlUpdate);
            ps.setString(1, user.getFullName());
            ps.setDate(2, new java.sql.Date(user.getBirthDate().getTime()));
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getRole());
            ps.setBytes(7, user.getAvatar());
            ps.setInt(8, user.getUserID());
            System.out.println(ps);
            int rowsUpdated = ps.executeUpdate();
            if(user.getPassword() != null && !user.getPassword().equals(""))
                updateUserPassword(user);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return false;
    }
    public boolean updateUserPassword(User user) throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        String sqlUpdatePass = "UPDATE Users SET Password = ? WHERE UserID = ?";
        try {

            PreparedStatement ps = conn.prepareStatement(sqlUpdatePass);
            ps.setString(1, user.getPassword());
            ps.setInt(2, user.getUserID());
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return false;
    }
    public boolean deleteUser(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement statement = conn.prepareStatement(DELETE_User_By_UserID);)
        {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public User selectUserById(int userId) {
        User user = null;
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(Select_User_By_UserID);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setBirthDate(rs.getDate("BirthDate"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setEmail(rs.getString("Email"));
                user.setRole(rs.getString("Role"));
                user.setAvatar(rs.getBytes("Avatar"));
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return user;
    }

    public int loginUser(User user) throws SQLException{
        int id = -1;
        Connection conn = JDBCUtil.getConnection();
        try
        {
            PreparedStatement statement = conn.prepareStatement(sqlLogin);
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());
            ResultSet rs = statement.executeQuery();
            while(rs.next())
            {
                id = rs.getInt("UserID");
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
            return -1;
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return id;
    }
    public boolean checkUserOldPassword(User user) throws SQLException{
        int id = -1;
        String sqlCheckOldPass = "SELECT * FROM Users WHERE UserID = ? AND Password = ?";
        Connection conn = JDBCUtil.getConnection();
        try
        {
            PreparedStatement statement = conn.prepareStatement(sqlCheckOldPass);
            statement.setInt(1, user.getUserID());
            statement.setString(2, user.getPassword());
            ResultSet rs = statement.executeQuery();
            while(rs.next())
            {
                id = rs.getInt("UserID");
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
            return id == -1;
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return id == -1;
    }
}
