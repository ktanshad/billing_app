class ProductModel{
   String? id;
   String? name;
   int? rate;
   int? gst;


   ProductModel({
     this.id,
    required this.name,
    required this.rate,
    required this.gst
   });

   factory ProductModel.fromMap(Map<String,dynamic>map,String id){
    return ProductModel(
      id: id,
      name: map['productName'] ?? '',
      rate: map['rate'] ?? '',
      gst: map['gst'] ?? '',
    );
   }


  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'rate': rate,
      'gst': gst,
    };
  }



}