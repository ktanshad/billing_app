class CustomerModel{
   String? id;
   String? name;
   String? phone;
   String? address;


   CustomerModel({
     this.id,
    required this.name,
    required this.phone,
    required this.address
   });

   factory CustomerModel.fromMap(Map<String,dynamic>map,String id){
    return CustomerModel(
      id: id,
      name: map['costomerName'] ?? '',
      phone: map['customerPhoneNumber'] ?? '',
      address: map['customerAddress'] ?? '',
    );
   }


  Map<String, dynamic> toMap() {
    return {
      'costomerName': name,
      'customerPhoneNumber': phone,
      'customerAddress': address,
    };
  }



}