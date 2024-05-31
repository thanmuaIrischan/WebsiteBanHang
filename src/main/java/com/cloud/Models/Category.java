package com.cloud.Models;

import java.io.Serializable;
import java.util.Date;

public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    private int categoryID;
    private String categoryName;
    private Date dateAdd;

    public Category()
    {
        super();
    }

    public Category(int categoryID, String categoryName, Date dateAdd)
    {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.dateAdd = dateAdd;
    }
    public Category(String categoryName, Date dateAdd)
    {
        this.categoryName = categoryName;
        this.dateAdd = dateAdd;
    }

    // Getters and Setters
    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Date getDateAdd() {
        return dateAdd;
    }

    public void setDateAdd(Date dateAdd) {
        this.dateAdd = dateAdd;
    }
}
