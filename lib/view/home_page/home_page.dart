import 'package:billing_app/controller/auth_provider.dart';
import 'package:billing_app/controller/bill_amount_provider.dart';
import 'package:billing_app/controller/customer_provider.dart';
import 'package:billing_app/controller/product_provider.dart';
import 'package:billing_app/helpers/colors.dart';
import 'package:billing_app/billinh_page/billing_page.dart';
import 'package:billing_app/view/home_page/widgets/customer_products_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<HomePage> {
    @override
  void initState() {
    final customerProvider=Provider.of<CustomerProvider>(context,listen: false);
    final productProvider=Provider.of<ProductProvider>(context,listen: false);
      productProvider.fetchProducts();
    customerProvider.fetchCustomer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 208, 208),
     appBar: AppBar(title: Text("Home Page",style: TextStyle(fontWeight: FontWeight.bold,color: backgroundcolor)),
      backgroundColor: Color.fromARGB(255, 210, 208, 208),
     elevation: 0,
          actions: [
            //sign out button
            IconButton(
              onPressed: ()async {
                //get auth service
                final authprovider =
                    Provider.of<AuthProvider>(context, listen: false);
                authprovider.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
     ),
     floatingActionButton: FloatingActionButton(
      backgroundColor: backgroundcolor,
        child:  Icon(
        Icons.add,
        size: 35,
        color: kWhiteColor,
      ),
      onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context) => BillingPage(),));
     }),
     body:Consumer<CustomerProvider>(builder: (context, customerProvider, child) {
       if (customerProvider.customers.isEmpty) {
          return Center(
            child: Text(
              'data empty',
              style: TextStyle(fontSize: 16.0),
            ),
          );
        } else {
       return  ListView.builder(
             shrinkWrap: true,
             itemCount: customerProvider.customers.length,
             itemBuilder: (context, index) {
               final customer = customerProvider.customers[index];
               return Card(
                color: backgroundcolor,
                 child: ListTile(
                   title: Text(customer.name ?? '',style: TextStyle(color: kWhiteColor),),
                   onTap: () async{  
                       final billamountProvider=Provider.of<BillAmountProvider>(context,listen: false);
                       await billamountProvider.fetchSaledProducts(customer.id!);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => CustomerProductPage(customerId: customer.id,customerName: customer.name, ),));
                   },
                 ),
               );
             },
                   );
        }
     },
   
     ),
    );
  }
}