package com.cloud.DTOs;

import com.cloud.Models.Product;
import com.cloud.Models.Cart;

import java.math.BigDecimal;
import java.util.Base64;

public class CartDetail {
    private int cartID;
    private int userID;
    private int productID;
    private int quantity;
    private String productName;
    private BigDecimal productPrice;
    private int productStock;
    private byte[] productImage;
    private String base64ProductImage;

    public CartDetail(Cart cart, Product product) {
        this.cartID = cart.getCartID();
        this.userID = cart.getUserID();
        this.productID = cart.getProductID();
        this.quantity = cart.getQuantity();
        this.productName = product.getName();
        this.productPrice = product.getPrice();
        this.productStock = product.getStock();
        this.productImage = product.getImage();
        setBase64ProductImage(this.productImage);
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public int getProductStock() {
        return productStock;
    }

    public void setProductStock(int productStock) {
        this.productStock = productStock;
    }

    public byte[] getProductImage() {
        return productImage;
    }

    public void setProductImage(byte[] productImage) {
        this.productImage = productImage;
    }

    public void setBase64ProductImage(byte[] productImage) {
        if (productImage != null && productImage.length > 0) {
            this.base64ProductImage = Base64.getEncoder().encodeToString(productImage);
        }
    }

    public String getBase64ProductImage() {
        return base64ProductImage;
    }
}
