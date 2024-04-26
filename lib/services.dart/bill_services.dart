
import 'package:billing_app/model/bill_amount_model.dart';
import 'package:billing_app/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BillAmountServices {
     final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference firebaseSalesman =
      FirebaseFirestore.instance.collection('salesman');
      // instance.collection('customers')

  Future<List<BillAmountModel>> fetchSaledProducts(String costomerId) async {
    final snapshot = await firebaseSalesman.doc(firebaseAuth.currentUser!.uid).collection('customers').doc(costomerId).collection("saledProducts").get();
    return snapshot.docs.map((doc) {
      return BillAmountModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // void deleteCustomers(String docId) {
  //   firebaseCustomers.doc(docId).delete();
  // }

  Future<void> addBillAmount(BillAmountModel billdetails,String cousmerId)async {
  await firebaseSalesman.doc(firebaseAuth.currentUser!.uid).collection('customers').doc(cousmerId).collection("saledProducts").doc().set(billdetails.toMap());
  }

  // void updateCustomers(CustomerModel customers) {
  //   final data = customers.toMap();
  //   firebaseCustomers.doc(customers.id).update(data);
  // }
}
