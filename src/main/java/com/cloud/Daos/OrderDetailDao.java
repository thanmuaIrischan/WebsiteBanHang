package com.cloud.Daos;

import com.cloud.Models.Cart;
import com.cloud.Models.OrderDetail;
import com.cloud.Util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.List;

public class OrderDetailDao {
    final String INSERT_NEW_DETAIL = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES (?, ?, ?)";

    public int create (int orderid, List<Cart> cart) {
        Connection conn = JDBCUtil.getConnection();
        Savepoint beforeInsert = null;
        try (PreparedStatement preparedStatement = conn.prepareStatement(INSERT_NEW_DETAIL)) {
            conn.setAutoCommit(false);

            for (Cart item : cart) {
                preparedStatement.setInt(1, orderid);
                preparedStatement.setInt(2, item.getProductID());
                preparedStatement.setInt(3, item.getQuantity());
                preparedStatement.addBatch();
            }

            beforeInsert = conn.setSavepoint();
            int[] rowInserted = preparedStatement.executeBatch();
            int totalRowInserted = 0;
            for (int i : rowInserted)
                totalRowInserted += i;
            conn.commit();

            return totalRowInserted;
        } catch (SQLException ex) {
            try {
                conn.rollback(beforeInsert);
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
