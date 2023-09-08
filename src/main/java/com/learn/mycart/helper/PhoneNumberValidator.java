
package com.learn.mycart.helper;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PhoneNumberValidator {
    public static boolean isValidPhoneNumber(String phoneNumber) {
        // Define a regex pattern for a valid phone number format
        // This example allows for common formats, including +1234567890, (123) 456-7890, and 123-456-7890
        String regex = "^(\\+\\d{1,4}[-]?)?\\s*\\(?\\d{1,4}\\)?[-\\s]?\\d{1,4}[-\\s]?\\d{1,9}$";
        
        // Create a Pattern object
        Pattern pattern = Pattern.compile(regex);
        
        // Create a Matcher object and match it against the input phone number
        Matcher matcher = pattern.matcher(phoneNumber);
        
        // Return true if the phone number matches the regex pattern, indicating a valid format
        return matcher.matches();
    }
}
