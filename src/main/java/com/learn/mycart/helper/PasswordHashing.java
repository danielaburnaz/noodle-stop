package com.learn.mycart.helper;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PasswordHashing {
    public static String doHashing(String password){
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA");
            messageDigest.update(password.getBytes());
            byte[] resultByteArray = messageDigest.digest();
            
            StringBuilder sb = new StringBuilder();
            for (byte b : resultByteArray) {
                sb.append(String.format("%02x", b));
            }
            
            return sb.toString();
            
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(PasswordHashing.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return "";
    }
}
