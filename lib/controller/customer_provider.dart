import 'package:billing_app/model/customer_model.dart';
import 'package:billing_app/services.dart/customer_services.dart';
import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier{
 final CustomerServices customerServices = CustomerServices();
  TextEditingController addCustomerNameController = TextEditingController();
  TextEditingController addCustomerPhoneNummberController = TextEditingController();
   TextEditingController addCustomeraddressController = TextEditingController();
  List<CustomerModel> customers = [];
  List<CustomerModel> filteredCustomers = [];
   void filterCustomers(String value) {

    filteredCustomers = customers.where((customer) =>
        customer.name!.toLowerCase().contains(value.toLowerCase())).toList();
    notifyListeners();
  }

  Future<void> fetchCustomer() async {
    customers = await customerServices.fetchCustomers();
    notifyListeners();
  }

  // Future<void> deleteCustomer(String docId) async {
  //   customerServices.deleteCustomers(docId);
  //   await fetchCustomer();
  //   notifyListeners();
  // }

 Future<void> addCustomer() async {
   final customer= CustomerModel(
   
     name:addCustomerNameController.text,
      phone: addCustomerPhoneNummberController.text,
       address: addCustomeraddressController.text,
       );
       customerServices.addCustomers( customer);
      await fetchCustomer();
    notifyListeners();

  }

  // void updateCustomer(String docId) async { 
  // final customer=CustomerModel(
  //   id: docId,
  //    name:addCustomerNameController.text,
  //     phone: addCustomerPhoneNummberController.text,
  //      address:addCustomeraddressController.text
  //      );
  //      customerServices.updateCustomers(customer);
  //   await fetchCustomer();
  //   notifyListeners();
  // }

}