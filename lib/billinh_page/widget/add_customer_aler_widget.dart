import 'package:flutter/material.dart';

class AddCustomerAlertDialog extends StatelessWidget {
  final TextEditingController addCustomerNameController;
  final TextEditingController addCustomerPhoneNummberController;
  final TextEditingController addCustomeraddressController;
  final Function() onCancel;
  final Function() onSubmit;

  const AddCustomerAlertDialog({
    required this.addCustomerNameController,
    required this.addCustomerPhoneNummberController,
    required this.addCustomeraddressController,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: addCustomerNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter customer name  ",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              controller: addCustomerPhoneNummberController,
              decoration: const InputDecoration(
              
                border: OutlineInputBorder(),
                hintText: "Enter phone number  ",
              ),
            ),
            
            SizedBox(height: 10),
            TextFormField(
              controller: addCustomeraddressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "address ",
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          onPressed: onCancel,
        ),
        TextButton(
          child: const Text(
            "submit",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          onPressed: onSubmit,
        ),
      ],
    );
  }
}
