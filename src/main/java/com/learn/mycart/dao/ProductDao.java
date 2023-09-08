
package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory){
        this.factory = factory;
    }
    
    public boolean saveProduct(Product product){
        boolean bool=false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            
            session.save(product);
            
            tx.commit();
            session.close();
            bool=true;
        } catch (Exception e) {
            //add error message which contains e.printStackTrace();
            bool=false;
        }
        return bool;
    }
    
    //return product list with all products
    public List<Product> getAllProducts(){
        Session session = this.factory.openSession();
        Query query = session.createQuery("from Product");
        List<Product> list = query.list();
        return list;
    }

    //return products from the selected category
    public List<Product> getAllProductsById(int cId){
        Session session = this.factory.openSession();
        Query query = session.createQuery("from Product as p where p.category.categoryId =: id");
        query.setParameter("id", cId);
        List<Product> list = query.list();
        return list;
    }
    
//    retrieve a product by its ID.
    public Product getProductById(int pId) {
        Session session = this.factory.openSession();
        return session.get(Product.class, pId);
    }
    
    public void updateProduct(Product product) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        try {
            session.update(product); // This will update the product in the database
            tx.commit();
        } catch (Exception e) {
            // Handle exceptions and rollback if needed
            tx.rollback();
        } finally {
            session.close();
        }
    }
    public void deleteProduct(Product product) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        try {
            session.delete(product); // This will delete the product from the database
            tx.commit();
        } catch (Exception e) {
            // Handle exceptions and rollback if needed
            tx.rollback();
        } finally {
            session.close();
        }
    }
}
