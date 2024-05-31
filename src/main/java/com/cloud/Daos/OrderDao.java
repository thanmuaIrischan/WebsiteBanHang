package com.cloud.Daos;

import com.cloud.Util.JDBCUtil;

import java.sql.*;

public class OrderDao {
    final String INSERT_NEW_ORDER = "INSERT INTO Orders (UserID, OrderDateTime) VALUES (?, now())";
    public int create(int userid) {
        Connection conn = JDBCUtil.getConnection();
        try (PreparedStatement preparedStatement = conn.prepareStatement(INSERT_NEW_ORDER, Statement.RETURN_GENERATED_KEYS)) {
            conn.setAutoCommit(false);
            preparedStatement.setInt(1, userid);

            int rowInserted = preparedStatement.executeUpdate();
            conn.commit();

            int orderid = 0;
            if (rowInserted > 0) {
                ResultSet rs = preparedStatement.getGeneratedKeys();
                if (rs.next()) {
                    orderid = rs.getInt(1);
                }
            }

            return orderid;

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
