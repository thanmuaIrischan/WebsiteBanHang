package com.cloud.Dto;

import lombok.*;

import java.math.BigDecimal;
import java.util.Date;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ProductDto {
    private int productID;
    private String name;
    private String description;
    private BigDecimal price;
    private int discount;
    private int stock;
    private byte[] image;
}
