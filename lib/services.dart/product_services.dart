
import 'package:billing_app/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference firebaseSalesman =
      FirebaseFirestore.instance.collection('salesman');

  Future<List<ProductModel>> fetchProducts() async {
    final snapshot = await firebaseSalesman.doc(firebaseAuth.currentUser!.uid).collection('products').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // void deleteProduct(String docId) {
  //   firebaseProducts.doc(docId).delete();
  // }

  void addProduct(ProductModel products) async{
    final data=await firebaseSalesman.doc(firebaseAuth.currentUser!.uid).collection('products');
    data.add(products.toMap());
  }

  // void updateProduct(ProductModel products) {
  //   final data = products.toMap();
  //   firebaseProducts.doc(products.id).update(data);
  // }
}
