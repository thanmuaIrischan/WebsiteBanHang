package com.cloud.Models;

import java.io.Serializable;
import java.util.Date;
import java.math.BigDecimal;

public class Invoice implements Serializable {
    private static final long serialVersionUID = 1L;

    private int invoiceID;
    private int orderID;



    private Date invoiceDateTime;
    private Double total;
    private int typePayment;

    public String getTypePaymentString() {
        return (typePayment == 1) ? "Credit" : "COD";
    }

    public int getTypePayment() {
        return typePayment;
    }
    public void setTypePayment(int typePayment) {
        this.typePayment = typePayment;
    }

    public String getStatusString() {
        return (status ==1 )? "Done": "Pending";
    }
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }

    private int status;
    public Invoice() {
    }

    // Getters and Setters
    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getInvoiceDateTime() {
        return invoiceDateTime;
    }

    public void setInvoiceDateTime(Date invoiceDateTime) {
        this.invoiceDateTime = invoiceDateTime;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

}
