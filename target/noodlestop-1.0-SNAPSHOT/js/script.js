function add_to_cart(pId,pName,pPrice){
    let cart = localStorage.getItem("cart");
    if (cart === null){
//        no item in cart
        let products=[];
        let product={productId:pId, productName:pName, productQuantity:1, productPrice:pPrice};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
//        console.log("Product is added for the first time");
        showToast(product.productName + " has been added to cart.");
    } else {
//        items in cart
        let pCart = JSON.parse(cart);
        let oldProduct = pCart.find((item) => item.productId === pId);
        if(oldProduct){
//            increase quantity
            oldProduct.productQuantity = oldProduct.productQuantity+1;
            pCart.map((item)=>{
                if(item.productId===oldProduct.productId){
                    item.productQuantity=oldProduct.productQuantity;
                }
            });
            localStorage.setItem("cart", JSON.stringify(pCart));
//            console.log("Product quantity is increased");
            showToast(oldProduct.productName + " quantity is increased");
//            updateCart();
        } else {
//            add the product
            let product={productId:pId, productName:pName, productQuantity:1, productPrice:pPrice};
            pCart.push(product);
            localStorage.setItem("cart", JSON.stringify(pCart));
//            console.log("another product has been added");
            showToast( product.productName + " has been added to cart.");
        }
    }
    updateCart(); 
}

//update cart

function updateCart(){
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if(cart===null || cart.length===0){
        console.log("No items in cart.");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h2>No items in cart.</h2>");
        $(".checkout-btn").addClass('disabled');
        $(".order-now").addClass('disabled');
    } else {
//        show items
        console.log(cart);
        let totalQuantity = cart.reduce((total, item) => total + item.productQuantity, 0);
        $(".cart-items").html(`( ${totalQuantity} )`);
        let table =`
            <table class='table'>
            <thread class='thread-light'>
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th>
                </tr>
            </thread>
        `;
        
        let totalPrice=0;
        cart.map((item) =>{
           table +=`
                   <tr>
                        <td>${item.productName}</td>
                        <td>${item.productPrice}</td>
                        <td>${item.productQuantity}</td>
                        <td>${item.productQuantity * item.productPrice}</td>
                        <td><button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button></td>
                   </tr>
            `;
            totalPrice += item.productPrice * item.productQuantity;
        });
        
        table = table + `
                <tr><td colspan='5' class='text-right pr-5 font-weight-bold'>Total Price: ${totalPrice}</td></tr>  
                </table>`;
        $(".cart-body").html(table);
        $(".checkout-btn").removeClass('disabled');
        $(".order-now").removeClass('disabled');
    }
}

//delete item from cart
function deleteItemFromCart(pId){
    let cart=JSON.parse(localStorage.getItem('cart'));
    let newCart = cart.filter((item) => item.productId!==pId);
    localStorage.setItem('cart', JSON.stringify(newCart));
    updateCart(); 
    showToast("Product has been removed from cart.");
}

$(document).ready(function(){
    updateCart();   
});

function showToast(content){
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 2000); //its in miliseconds
}

function goToCheckout(){
    window.location = "checkout.jsp";
}




