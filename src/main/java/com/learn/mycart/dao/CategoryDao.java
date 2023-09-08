
package com.learn.mycart.dao;

import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {
    private SessionFactory factory;
    public CategoryDao(SessionFactory factory){
        this.factory = factory;
    }
    
    //saves category to database
    public int saveCategory(Category cat){ 
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(cat);
        
        tx.commit();
        session.close();
        return catId;
    }
    
    public List<Category> getCategories(){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Category");
        List<Category> list = query.list();
        return list;
    }
    
    public Category getCategorybyId(int cid){
        Category cat = null;
        try {
            Session session = this.factory.openSession();
            cat = session.get(Category.class,cid);
            session.close();
        } catch (Exception e) {
        }
        return cat;
    }
       public void updateCategory(Category cat) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        try {
            session.update(cat); // update the category in the database
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
    }
    public void deleteCategory(Category cat) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        try {
            session.delete(cat); //  delete the category from the database
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            session.close();
        }
    }
}