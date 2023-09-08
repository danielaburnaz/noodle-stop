
package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import com.learn.mycart.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public User getUserByEmailAndPassword(String email, String password){
        User user= null;
        try {
            String query="FROM User WHERE userEmail =: e AND userPassword =: p";
            Session session = this.factory.openSession();
            
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            user = (User) q.uniqueResult();
            
            session.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updateUser(User user) {

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            
        try {
            session.update(user); // This will update the user in the database
            tx.commit();
        } catch (Exception e) {
            // Handle exceptions and rollback if needed
            tx.rollback();
        } finally {
            session.close();
        }
    }
    
        public void deleteProduct(User user) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        try {
            session.delete(user); // This will delete the user from the database
            tx.commit();
        } catch (Exception e) {
            // Handle exceptions and rollback if needed
            tx.rollback();
        } finally {
            session.close();
        }
    }
}
