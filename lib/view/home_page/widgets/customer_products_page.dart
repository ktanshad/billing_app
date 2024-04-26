import 'package:billing_app/controller/bill_amount_provider.dart';
import 'package:billing_app/helpers/colors.dart';
import 'package:billing_app/model/bill_amount_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerProductPage extends StatefulWidget {
  const CustomerProductPage({super.key,required this.customerId,required this.customerName});
  final customerId;
  final customerName;

  @override
  State<CustomerProductPage> createState() => _CustomerProductPageState();
}

class _CustomerProductPageState extends State<CustomerProductPage> {
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(color: kWhiteColor),
      backgroundColor: backgroundcolor,
      title: Text(
        '${widget.customerName}',
        style: TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor),
      ),
    ),
    body: Consumer<BillAmountProvider>(
      builder: (context, billAmountProvider, child) {
         if (billAmountProvider.saledProducts.isEmpty) {
          return Center(
            child: Text(
              'data empty',
              style: TextStyle(fontSize: 16.0),
            ),
          );
        } else {
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Bill Amount')),
              ],
              rows: billAmountProvider.saledProducts.map((saledproducts) {
                return DataRow(cells: [
                  DataCell(Text(saledproducts.productName ?? '')),
                  DataCell(Text(saledproducts.quantity.toString() ?? '')),
                  DataCell(Text(saledproducts.billAmount.toString() ?? '')),
                ]);
              }).toList(),
            ),
          ),
        );
        }
      },
    ),
  );
}

}