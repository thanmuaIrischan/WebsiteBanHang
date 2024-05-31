package com.cloud.Daos;

import com.cloud.Models.Cart;
import com.cloud.Util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDao {
    final String SELECT_CART_BY_USER_ID = "SELECT * FROM Cart WHERE UserID=?";
    final String SELECT_CART_BY_CART_ID = "SELECT * FROM Cart WHERE CartID=?";
    final String INSERT_NEW_CART = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (?, ?, ?)";
    final String UPDATE_CART_BY_CART_ID = "UPDATE Cart SET Quatity=? WHERE CartID=?";
    final String DELETE_CART_BY_CART_ID = "DELETE FROM Cart WHERE CartID=?";
    final String DELETE_CART_BY_USER_ID = "DELETE FROM Cart WHERE UserID=?";



    public List<Cart> findAll(int userid) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(SELECT_CART_BY_USER_ID)) {
            preparedStatement.setInt(1, userid);
            ResultSet rs = preparedStatement.executeQuery();

            List<Cart> results = new ArrayList<>();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("CartID"));
                cart.setUserID(rs.getInt("UserID"));
                cart.setProductID(rs.getInt("ProductID"));
                cart.setQuantity(rs.getInt("Quantity"));

                results.add(cart);
            }

            return results;
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return null;
    }
    public List<Cart> findByCartID(int cartid) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(SELECT_CART_BY_CART_ID)) {
            preparedStatement.setInt(1, cartid);
            ResultSet rs = preparedStatement.executeQuery();

            List<Cart> results = new ArrayList<>();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("CartID"));
                cart.setUserID(rs.getInt("UserID"));
                cart.setProductID(rs.getInt("ProductID"));
                cart.setQuantity(rs.getInt("Quantity"));

                results.add(cart);
            }

            return results;
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return null;
    }
    public int create(Cart cart) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(INSERT_NEW_CART)) {
            preparedStatement.setInt(1, cart.getUserID());
            preparedStatement.setInt(2, cart.getProductID());
            preparedStatement.setInt(3, cart.getQuantity());

            return preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return 0;
    }
    public int update(int quantity, int cartid) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(UPDATE_CART_BY_CART_ID)) {
            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, cartid);

            return preparedStatement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return 0;
    }

    public int deleteByCartId(int cartid) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(DELETE_CART_BY_CART_ID)) {
            conn.setAutoCommit(false);
            preparedStatement.setInt(1, cartid);

            int rowAffected = preparedStatement.executeUpdate();
            conn.commit();

            return  rowAffected;
        } catch (SQLException ex) {
            try {
                conn.rollback();
            } catch (SQLException ex2) {
                ex2.printStackTrace();
            }
            ex.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return 0;
    }

    public int deleteByUserId(int userid) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(DELETE_CART_BY_USER_ID)) {
            conn.setAutoCommit(false);
            preparedStatement.setInt(1, userid);

            int rowAffected = preparedStatement.executeUpdate();
            conn.commit();

            return  rowAffected;
        } catch (SQLException ex) {
            try {
                conn.rollback();
            } catch (SQLException ex2) {
                ex2.printStackTrace();
            }
            ex.printStackTrace();
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return 0;
    }
}
