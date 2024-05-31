package com.cloud.Daos;

import com.cloud.Models.Category;
import com.cloud.Models.User;
import com.cloud.Util.HandleExeption;
import com.cloud.Util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao  {

    public List<Category> getAllCategory () {
        List<Category> categories = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            String sqlGetAllCategory = "SELECT * FROM Categories ";
            PreparedStatement ps = conn.prepareStatement(sqlGetAllCategory);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategorieName"));
                category.setDateAdd(rs.getDate("DateAdd"));

                categories.add(category);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return categories;
    }
    public Category selectCategoryByID(int categoryID ) {
        Category category = null;
        Connection conn = JDBCUtil.getConnection();
        try {
            String CategoryByID =  "SELECT * FROM Categories WHERE CategoryID = ?";
            PreparedStatement ps = conn.prepareStatement(CategoryByID);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new Category();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategorieName"));
                category.setDateAdd(rs.getDate("DateAdd"));
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return category;
    }

    public boolean updateCategory(Category category) throws SQLException {
        Connection conn = JDBCUtil.getConnection();
        try {
            String sqlUpdateCategory = "UPDATE Categories SET CategorieName = N? , DateAdd = N? WHERE CategoryID = ? ";
            PreparedStatement ps = conn.prepareStatement(sqlUpdateCategory);
            ps.setString(1, category.getCategoryName());
            ps.setDate(2, new java.sql.Date(category.getDateAdd().getTime()));
            ps.setInt(3, category.getCategoryID());
            System.out.println(ps);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return false;
    }
    public boolean Delete_Category(int CategoryID) throws SQLException {
        boolean rowDeleted;
        String Delete_Category = "DELETE FROM Categories WHERE CategoryID = ?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement statement = conn.prepareStatement(Delete_Category);)
        {
            statement.setInt(1, CategoryID);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean Insert_Category(Category category) {
        Connection conn = JDBCUtil.getConnection();
        try {
            String sqlInsertCategory = "INSERT INTO Categories (CategorieName, DateAdd) VALUES (?, ? )";
            PreparedStatement ps = conn.prepareStatement(sqlInsertCategory);
            ps.setString(1, category.getCategoryName());
            ps.setDate(2, new java.sql.Date(category.getDateAdd().getTime()));

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new category was inserted successfully!");
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
            return false;
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return true;
    }



}
