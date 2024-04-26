import 'package:billing_app/constants/contants.dart';
import 'package:billing_app/controller/bill_amount_provider.dart';
import 'package:billing_app/controller/customer_provider.dart';
import 'package:billing_app/controller/product_provider.dart';
import 'package:billing_app/helpers/colors.dart';
import 'package:billing_app/billinh_page/widget/add_customer_aler_widget.dart';
import 'package:billing_app/billinh_page/widget/add_product_aler_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  void initState() {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProducts();
    customerProvider.fetchCustomer();
    // TODO: implement initState
    super.initState();
  }
    final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final customerProvider = Provider.of<CustomerProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final billAmountProvider = Provider.of<BillAmountProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kWhiteColor),
          backgroundColor: backgroundcolor,
          title: Text(
            'Billing page',
            style: TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key:formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 9,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                           style: TextStyle(color: kWhiteColor),
                        onChanged: (value) {
                          customerProvider.filterCustomers(value);
                        },
                           validator: (value) {
                          if (value!.isEmpty || billAmountProvider.selectedCousmerId=="") {
                               return 'Please select name';
                                } else {
                                  return null;
                                    }
                                        },
                        controller: billAmountProvider.customerController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: backgroundcolor,
                          suffixIcon: IconButton(
                              onPressed: () {
                                //add coudtomer dialoge
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddCustomerAlertDialog(
                                      addCustomerNameController: customerProvider
                                          .addCustomerNameController,
                                      addCustomerPhoneNummberController:
                                          customerProvider
                                              .addCustomerPhoneNummberController,
                                      addCustomeraddressController:
                                          customerProvider
                                              .addCustomeraddressController,
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      },
                                      onSubmit: () async {
                                       await customerProvider.addCustomer();
                                        Navigator.of(context).pop();
                                        customerProvider.addCustomerNameController.clear();
                                         customerProvider.addCustomerPhoneNummberController.clear();
                                         customerProvider.addCustomeraddressController.clear();
              
                                      },
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add,color: kWhiteColor,)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kWhiteColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kWhiteColor),
                          ),
                          hintText: "customer name",
                          hintStyle: TextStyle(color: kWhiteColor,)
                        ),
                      )),
                    ],
                  ),
                  if (billAmountProvider.customerController.text.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: customerProvider.filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer =
                            customerProvider.filteredCustomers[index];
                        return ListTile(
                          title: Text(customer.name ?? ''),
                          onTap: () {
                            billAmountProvider.customerController.text =
                                customer.name!;
                            billAmountProvider.selectedCousmerId = customer.id;
                            customerProvider.filteredCustomers.clear();
                            print(billAmountProvider.customerController.text);
                            print(billAmountProvider.selectedCousmerId);
                          },
                        );
                      },
                    ),
                SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                             style: TextStyle(color: kWhiteColor),
                        onTap: () {
                          billAmountProvider
                              .clearvalue(customerProvider.filteredCustomers);
                        },
                        onChanged: (value) {
                          productProvider.filterProducts(value);
                        },
                         validator: (value) {
                          if (value!.isEmpty || billAmountProvider.selectedrate== 0) {
                               return 'Please select product';
                                } else {
                                  return null;
                                    }
                                        },
                        controller: billAmountProvider.productNameController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                //add coudtomer dialoge
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddProductAlertDialog(
                                      addProductNameController: productProvider
                                          .addProductNameController,
                                      addProductRateController: productProvider
                                          .addproductRateController,
                                      addProductGSTController:
                                          productProvider.addProductGSTController,
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      },
                                      onSubmit: () async {

                                       await productProvider.addProduct();
                                        Navigator.of(context).pop();
                                        productProvider.addProductNameController.clear();
                                         productProvider.addProductGSTController.clear();
                                         productProvider.addproductRateController.clear();
                                      },
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add,color: kWhiteColor,)),
                          enabledBorder: OutlineInputBorder(
                            
                            borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kWhiteColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kWhiteColor),
                          ),
                          fillColor: backgroundcolor,
                          filled: true,
                          hintText: "Product name",
                          hintStyle: TextStyle(color: kWhiteColor,)
                           
                        ),
                      )),
                    ],
                  ),
                  if (billAmountProvider.productNameController.text.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: productProvider.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final products = productProvider.filteredProducts[index];
                        return ListTile(
                          title: Text(products.name ?? ''),
                          onTap: () {
                            // Handle selection if needed
                            billAmountProvider.productNameController.text =
                                products.name!;
                            billAmountProvider.selectedgst = products.gst!;
                            billAmountProvider.selectedrate = products.rate!;
                            productProvider.filteredProducts.clear();
                            print(billAmountProvider.productNameController.text);
                            print(billAmountProvider.selectedrate);
                            print(billAmountProvider.selectedgst);
                          },
                        );
                      },
                    ),
                       kHeigt10,
                  Row(
                    children: [
                      Text("Quantity :",style: TextStyle(fontWeight: FontWeight.bold,color: backgroundcolor,fontSize:18),),
                      Expanded(child: SizedBox()),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                           validator: (value) {
                          if (value!.isEmpty ) {
                               return 'enter';
                                } else {
                                  return null;
                                    }
                                        },
                        
                           maxLength: 5,
                          onChanged: (_) {
                            billAmountProvider.submit();
                          },
                          onTap: () {
                            billAmountProvider
                                .clearvalue(productProvider.filteredProducts);
                          },
                          controller: billAmountProvider.quatintyController,
                         
                          decoration: const InputDecoration(
                            counterText: "",
                            
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                   
              
                      Expanded(child: SizedBox()),
                       Expanded(child: SizedBox())
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Bill amount:",style: TextStyle(fontWeight: FontWeight.bold,color:backgroundcolor,fontSize: 18 ),),
                      Consumer(
                        builder: (context, value, child) {
                          return  Text("${billAmountProvider.billAmount}",style: TextStyle(fontWeight: FontWeight.bold,color:backgroundcolor,fontSize: 18 ));
                        },
                        )
                    ],
                  ),
                  SizedBox(height: 20,),
                 GestureDetector(
                    onTap: () async{

                      if (formkey.currentState!.validate()  ) {


                       await  billAmountProvider.addBillAmount();

                       billAmountProvider.customerController.clear();
                       billAmountProvider.productNameController.clear();
                       billAmountProvider.quatintyController.clear();
                       billAmountProvider.selectedCousmerId="";
                       billAmountProvider.selectedrate=0;
                       billAmountProvider.billAmount=0;
                         ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Billing Success",
                                ),
                              ),
                            );
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
              color: backgroundcolor, borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
              "Submit",
              style: TextStyle(
                  color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
