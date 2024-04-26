
import 'package:billing_app/model/bill_amount_model.dart';
import 'package:billing_app/services.dart/bill_services.dart';
import 'package:flutter/cupertino.dart';

class BillAmountProvider extends ChangeNotifier{

   TextEditingController customerController=TextEditingController();
  TextEditingController productNameController=TextEditingController();
  TextEditingController quatintyController=TextEditingController();
  int? selectedgst;
  int? selectedrate=0;
  String? selectedCousmerId="";
  num? billAmount=0;
  List<BillAmountModel> saledProducts = [];


   BillAmountServices billAmountServices=BillAmountServices();


     Future<void> fetchSaledProducts(String customerId) async {
    saledProducts = await billAmountServices.fetchSaledProducts(customerId);
    notifyListeners();
  }


  Future<void>addBillAmount() async {
   final billdetails= BillAmountModel(productName: productNameController.text, quantity: int.parse(quatintyController.text), billAmount: billAmount);
       billAmountServices.addBillAmount(billdetails,selectedCousmerId!);
      // await fetchCustomer();
    notifyListeners();

  }




  void clearvalue(value) {
    value.clear();
    notifyListeners();
  }



    submit(){
      if (quatintyController.text.isEmpty) {
    billAmount = 0;
     notifyListeners();
      }else{
     var quant = int.parse(quatintyController.text);
    var amount= quant*selectedrate!;
    var gst = amount*quant*selectedgst!/100;
    
      billAmount=amount+gst;
      notifyListeners();
      print(amount);
    print(gst);
    print(selectedgst);
    print(selectedrate);
    print(billAmount);

      }
   
   
    
    
    
  }
}