package com.learn.mycart.entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length =10, name = "user_id")
    private int userId;
    @Column(length =100, name = "user_name")
    private String userName;
    @Column(length =100, name = "user_lastname")
    private String userLastName;
    @Column(unique = true, length =100, name = "user_email")
    private String userEmail;
    @Column(length =1000, name = "user_password")
    private String userPassword;
    @Column(length =20, name = "user_phone")
    private String userPhone;
    @Column(length =1500, name = "user_pic")
    private String userPic;
    @Column(length =1500, name = "user_address")
    private String userAddress;

    @Column(name = "user_type")
    private String userType;
    
    @Column(name = "date_of_birth")
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;
    
//    @Column(name = "credit")
//    private int credit;

    public User() {
    }
    
    public User(int userId, String userName,String userLastName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType, Date dateOfBirth) {
        this.userId = userId;
        this.userName = userName;
        this.userLastName = userLastName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userPic = userPic;
        this.userAddress = userAddress;

        this.userType = userType;
        
        this.dateOfBirth = dateOfBirth;
        
//        this.credit = credit;
    }

    public User(String userName,String userLastName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType, Date dateOfBirth) {
        this.userName = userName;
        this.userLastName = userLastName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userPic = userPic;
        this.userAddress = userAddress;

        this.userType = userType;
        
        this.dateOfBirth = dateOfBirth;
        
//        this.credit = credit;
    }


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserLastName() {
        return userLastName;
    }

    public void setUserLastName(String userLastName) {
        this.userLastName = userLastName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserPic() {
        return userPic;
    }

    public void setUserPic(String userPic) {
        this.userPic = userPic;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

//    public int getCredit() {
//        return credit;
//    }
//
//    public void setCredit(int credit) {
//        this.credit = credit;
//    }
    
    

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", userName=" + userName + ", userLastName=" + userLastName + ", userEmail=" + userEmail + ", userPassword=" + userPassword + ", userPhone=" + userPhone + ", userPic=" + userPic + ", userAddress=" + userAddress + ", userType= " + userType+ ", dateOfBirth= " + dateOfBirth + '}';
    }
    
    
}
