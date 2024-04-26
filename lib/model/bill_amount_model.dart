class BillAmountModel{
   String? id;
   String? productName;
   int? quantity;
   num? billAmount;
 


   BillAmountModel({
     this.id,
    required this.productName,
    required this.quantity,
    required this.billAmount
  
   });

   factory BillAmountModel.fromMap(Map<String,dynamic>map,String id){
    return BillAmountModel(
      id: id,
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? '',
      billAmount:map["billAmount"]??""
    );
   }


  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'quantity': quantity,
       "billAmount":billAmount
    };
  }



}