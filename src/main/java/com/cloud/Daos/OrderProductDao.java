package com.cloud.Daos;

import com.cloud.Models.Invoice;
import com.cloud.Models.OrderProduct;
import com.cloud.Util.HandleExeption;
import com.cloud.Util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderProductDao {
    private String sqlGet = "Select * from OrderProduct\n" +
            "Where OrderID = ?";
    public List<OrderProduct> getOrderProduct(int oderid){
        List<OrderProduct> orderProducts = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlGet);
            ps.setInt(1,oderid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderProduct orderProduct = new OrderProduct();
                orderProduct.setProductID(rs.getString("productID"));
                orderProduct.setName(rs.getString("name"));
                orderProduct.setImage(rs.getBytes("image"));
                orderProduct.setPrice(rs.getBigDecimal("price"));
                orderProduct.setOrderID(rs.getInt("orderID"));
                orderProduct.setQuantity(rs.getInt("quantity"));
                orderProducts.add(orderProduct);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return orderProducts;
    }
}
