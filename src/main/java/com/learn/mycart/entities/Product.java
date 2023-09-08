
package com.learn.mycart.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pId;
    private String pName;
    @Column(length = 3000)
    private String pDesc;
    private String pPhoto;
//daca crapa aplicatia e din vina lui pPrice
//in acest caz schimba in int
    private Double pPrice;
    private int pDiscount;
    private int pQuantity;
    @ManyToOne
    private Category category;

    public Product() {
    }
    
    public Product(int pId, String pName, String pDesc, String pPhoto, Double pPrice, int pDiscount, int pQuantity, Category category) {
        this.pId = pId;
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPhoto = pPhoto;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.category = category;
    }


    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public String getpPhoto() {
        return pPhoto;
    }

    public void setpPhoto(String pPhoto) {
        this.pPhoto = pPhoto;
    }

    public Double getpPrice() {
        return pPrice;
    }

    public void setpPrice(Double pPrice) {
        this.pPrice = pPrice;
    }

    public int getpDiscount() {
        return pDiscount;
    }

    public void setpDiscount(int pDiscount) {
        this.pDiscount = pDiscount;
    }

    public int getpQuantity() {
        return pQuantity;
    }

    public void setpQuantity(int pQuantity) {
        this.pQuantity = pQuantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    
    
    @Override
    public String toString() {
        return "Product{" + "pId=" + pId + ", pName=" + pName + ", pDesc=" + pDesc + ", pPhoto=" + pPhoto + ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pQuantity=" + pQuantity + '}';
    }
    
//    calculate price after discount
//                daca crapa aplicatia e din vina lui pPrice
    public Double getPriceAfterApplyingDiscount(){
        Double d;
        if (this.getpDiscount()!=0){
            d =((this.getpDiscount()/100.0)*this.getpPrice());
            return this.getpPrice()-d;
        }
        d=0.00;
        return this.getpPrice()-d;
    }
    
}
