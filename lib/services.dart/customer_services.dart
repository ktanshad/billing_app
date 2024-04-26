
import 'package:billing_app/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerServices {
   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference firebaseCustomers =
      FirebaseFirestore.instance.collection('salesman');

  Future<List<CustomerModel>> fetchCustomers() async {
    final snapshot = await firebaseCustomers.doc(firebaseAuth.currentUser!.uid).collection('customers').get();
    return snapshot.docs.map((doc) {
      return CustomerModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // void deleteCustomers(String docId) {
  //   firebaseCustomers.doc(docId).delete();
  // }

  void addCustomers(CustomerModel customers)async {
    final data=await firebaseCustomers.doc(firebaseAuth.currentUser!.uid).collection('customers');
    data.add(customers.toMap());
  }

  // void updateCustomers(CustomerModel customers) {
  //   final data = customers.toMap();
  //   firebaseCustomers.doc(customers.id).update(data);
  // }
}
