package com.cloud.Models;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private int productID;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private byte[] image;
    private Date dateAdd;
    private int categoryID;
    private BigDecimal rate;

    public Product()
    {
        super();
    }

    public Product(String name, String description, BigDecimal price, int stock, byte[] image, Date dateAdd, int categoryID, BigDecimal rate) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.dateAdd = dateAdd;
        this.categoryID = categoryID;
        this.rate = rate;

    }

    public Product(int productID, String name, String description, BigDecimal price, int stock, byte[] image, java.sql.Date dateAdd, int categoryID, BigDecimal rate) {
        this.productID = productID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.dateAdd = dateAdd;
        this.categoryID = categoryID;
        this.rate = rate;
    }

    // Getters and Setters
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public Date getDateAdd() {
        return dateAdd;
    }

    public void setDateAdd(Date dateAdd) {
        this.dateAdd = dateAdd;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }
    public BigDecimal getRate() {
        return rate;
    }

    public void setRate(BigDecimal rate) {
        this.rate = rate;
    }
}
