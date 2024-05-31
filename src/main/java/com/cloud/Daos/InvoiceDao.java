package com.cloud.Daos;

import com.cloud.Models.Invoice;
import com.cloud.Models.Product;
import com.cloud.Util.HandleExeption;
import com.cloud.Util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InvoiceDao {
    private final String sqlGet = "SELECT * FROM ShoeStore.Invoices order by InvoiceID desc";
    private String sqlUpdate = "Update ShoeStore.Invoices\n" +
            "set status = ?\n" +
            "where InvoiceID =?";
    private final String sqlInsert = "INSERT INTO Invoices (OrderID, InvoiceDateTime, Total, TypePayment, Status) VALUES (?, now(), ?, ?, ?)";

    public List<Invoice> getInvoice(){
        List<Invoice> invoices = new ArrayList<>();
        Connection conn = JDBCUtil.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement(sqlGet);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceID(rs.getInt("InvoiceID"));
                invoice.setOrderID(rs.getInt("OrderID"));
                invoice.setInvoiceDateTime(rs.getDate("InvoiceDateTime"));
                invoice.setTotal(rs.getDouble("Total"));
                invoice.setTypePayment(rs.getInt("TypePayment"));
                invoice.setStatus(rs.getInt("status"));
                invoices.add(invoice);
            }
        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }

        return invoices;
    }
    public boolean updateInvoice(int idinvoice, int status){
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlUpdate);
            ps.setInt(1,status);
            ps.setInt(2,idinvoice);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return false;
    }
    public boolean insertInvoice(Invoice invoice) {
        Connection conn = JDBCUtil.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sqlInsert);
            ps.setInt(1, invoice.getOrderID());
            ps.setDouble(2, invoice.getTotal());
            ps.setInt(3, invoice.getTypePayment());
            ps.setInt(4, invoice.getStatus());

            int rowInserted = ps.executeUpdate();
            return rowInserted > 0;

        } catch (SQLException e) {
            HandleExeption.printSQLException(e);
        } finally {
            JDBCUtil.closeConnection(conn);
        }
        return false;
    }
}
