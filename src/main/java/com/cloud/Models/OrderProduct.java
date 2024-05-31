package com.cloud.Models;

import java.math.BigDecimal;

public class OrderProduct {
    String productID;
    String name;
    private byte[] image;
    private BigDecimal price;
    private  int orderID;
    private int quantity;

    public OrderProduct() {
    }

    public OrderProduct(String productID, String name, byte[] image, BigDecimal price, int orderID, int quantity) {
        this.productID = productID;
        this.name = name;
        this.image = image;
        this.price = price;
        this.orderID = orderID;
        this.quantity = quantity;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
