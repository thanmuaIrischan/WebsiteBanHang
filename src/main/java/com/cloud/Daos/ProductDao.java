package com.cloud.Daos;

import com.cloud.Models.Product;
import com.cloud.Util.HandleExeption;
import com.cloud.Util.JDBCUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    String sqlGetAll = "SELECT * FROM Products WHERE Name LIKE CONCAT('%', ?, '%');";
    String sqlGetProductOnPopular = "SELECT p.ProductID, p.Name,p.Image, p.Description, p.Price, p.Stock, p.DateAdd, p.CategoryID, p.Rate, COUNT(od.ProductID) AS PurchaseCount FROM Products p JOIN OrderDetails od ON p.ProductID = od.ProductID WHERE p.Name LIKE CONCAT('%', ?, '%') GROUP BY p.ProductID, p.Name, p.Description, p.Price, p.Stock, p.DateAdd, p.CategoryID, p.Rate ORDER BY PurchaseCount DESC LIMIT ?;";
    String sqlGetRandom = "SELECT * FROM Products ORDER BY RAND() LIMIT ?";
    String sqlInsert = "INSERT INTO Products (Name, Description, Price, Stock, Image, DateAdd, CategoryID, Rate) VALUES (?,?,?,?,?,?,?,?)";
    String DELETE_Product_By_ProductID = "DELETE FROM Products WHERE ProductID = ?";
    String sqlUpdate = "UPDATE Products SET Name = N?, Description = N?, Price = ?, Stock = ?, Image = ?, DateAdd = ?, CategoryID = ?, Rate = ? WHERE ProductID = ?";
    String Select_Product_By_ProductID = "SELECT * FROM Products WHERE ProductID = ?";
    String sqlGetAllProductOnWeek = "SELECT * FROM Products WHERE DateAdd >= CURDATE() - INTERVAL 1 WEEK AND DateAdd <= CURDATE() AND Name LIKE CONCAT('%', ? , '%');";
    public List<Product> getAllProducts () {
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetAll);
            ps.setString(1, "");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(rs.getBigDecimal("Rate"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }

    public List<Product> getAllProducts (String searchValue) {
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetAll);
            ps.setString(1, searchValue);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(rs.getBigDecimal("Rate"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }



    public void addProduct(Product product) {
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlInsert);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setBytes(5,product.getImage());
            ps.setDate(6, new java.sql.Date(product.getDateAdd().getTime()));
            ps.setInt(7, product.getCategoryID());
            ps.setBigDecimal(8, product.getRate());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new product was inserted successfully!");
            }
            else{
                System.out.println("A new product was inserted failed!");
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
    }
    public List<Product> getAllProductsRandomly (int maxSize) {
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetRandom);
            ps.setInt(1, maxSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }


    public Product selectProById(int proID) {
        Product product = null;
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(Select_Product_By_ProductID);
            ps.setInt(1, proID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(BigDecimal.valueOf(rs.getInt("Price")));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(BigDecimal.valueOf(rs.getInt("Rate")));
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return product;
    }

    public boolean updateProduct(Product product) {
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlUpdate);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setBytes(5,product.getImage());
            ps.setDate(6, new java.sql.Date(product.getDateAdd().getTime()));
            ps.setInt(7, product.getCategoryID());
            ps.setBigDecimal(8, product.getRate());
            ps.setInt(9, product.getProductID());
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

    public boolean deleteProduct(int productID) throws SQLException {
        boolean rowDeleted;
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement statement = conn.prepareStatement(DELETE_Product_By_ProductID);)
        {
            statement.setInt(1, productID);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public List<Product> getAllProductOnPopular(int limit){
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetProductOnPopular);
            ps.setInt(2,limit);
            ps.setString(1, "");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(rs.getBigDecimal("Rate"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }

    public List<Product> getAllProductOnPopular(int limit, String searchValue){
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetProductOnPopular);
            ps.setInt(2,limit);
            ps.setString(1, searchValue);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(rs.getBigDecimal("Rate"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }

    public List<Product> getAllNewProductOnWeek () {
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetAllProductOnWeek);
            ps.setString(1, "");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(rs.getBigDecimal("Rate"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }

    public List<Product> getAllNewProductOnWeek (String searchValue) {
        List<Product> products = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGetAllProductOnWeek);
            ps.setString(1,searchValue);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImage(rs.getBytes("Image"));
                product.setDateAdd(rs.getDate("DateAdd"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setRate(rs.getBigDecimal("Rate"));
                products.add(product);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return products;
    }
}