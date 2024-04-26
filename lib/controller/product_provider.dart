
import 'package:billing_app/model/product_model.dart';
import 'package:billing_app/services.dart/product_services.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
 final ProductServices productServices = ProductServices();
  TextEditingController addProductNameController = TextEditingController();
  TextEditingController addproductRateController = TextEditingController();
   TextEditingController addProductGSTController = TextEditingController();
  List<ProductModel> products = [];
  

   List<ProductModel> filteredProducts = [];
   void filterProducts(String value) {

    filteredProducts = products.where((products) =>
        products.name!.toLowerCase().contains(value.toLowerCase())).toList();
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    products = await productServices.fetchProducts();
    notifyListeners();
  }

  // Future<void> deleteProduct(String docId) async {
  //   productServices.deleteProduct(docId);
  //   await fetchProducts();
  //   notifyListeners();
  // }

  Future<void> addProduct() async {
   final products= ProductModel(
   
     name:addProductNameController.text,
      rate: int.parse(addproductRateController.text,),
       gst: int.parse(addProductGSTController.text)
       );
       productServices.addProduct( products);
      await fetchProducts();
      print(products.gst.runtimeType);
    notifyListeners();

  }

  // void updateCustomer(String docId) async { 
  // final products=ProductModel(
  //   id: docId,
  //    name:addProductNameController.text,
  //     rate: int.parse(addproductRateController.text,),
  //     gst:int.parse(addProductGSTController.text),
  //      );
  //      productServices.updateProduct(products);
  //   await fetchProducts();
  //   notifyListeners();
  // }

}