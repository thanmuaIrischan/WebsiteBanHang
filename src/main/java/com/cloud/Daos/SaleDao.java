package com.cloud.Daos;

import com.cloud.Models.Product;
import com.cloud.Models.Sale;
import com.cloud.Util.HandleExeption;
import com.cloud.Util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SaleDao {
    private String SEARCH_ITEM_DISCOUNT = "SELECT * FROM Sales WHERE ProductID = ? AND StartDate <= CURRENT_DATE AND EndDate >= CURRENT_DATE LIMIT 1";
    private String INSERT_SALE = "INSERT INTO Sales (ProductID, StartDate, EndDate, DiscountPercent) VALUES (?, ?, ?, ?)";
    public Sale searchSaleProduct (int productID) {
        Connection conn = JDBCUtil.getConnection();
        Sale sale = null;
        try {
            PreparedStatement ps = conn.prepareStatement(SEARCH_ITEM_DISCOUNT);
            ps.setInt(1,productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                sale = new Sale();
                sale.setSaleID(rs.getInt("SaleID"));
                sale.setProductID(rs.getInt("ProductID"));
                sale.setStartDate(rs.getDate("StartDate"));
                sale.setEndDate(rs.getDate("EndDate"));
                sale.setDiscountPercent(rs.getInt("DiscountPercent"));
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        if(sale == null) {
            sale = new Sale();
            sale.setDiscountPercent(
                    0
            );
        }
        return sale;
    }
}
