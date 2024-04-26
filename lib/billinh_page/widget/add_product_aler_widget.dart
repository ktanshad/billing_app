import 'package:flutter/material.dart';

class AddProductAlertDialog extends StatelessWidget {
  final TextEditingController addProductNameController;
  final TextEditingController addProductRateController;
  final TextEditingController addProductGSTController;
  final Function() onCancel;
  final Function() onSubmit;

  const AddProductAlertDialog({
    required this.addProductNameController,
    required this.addProductRateController,
    required this.addProductGSTController,
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
              controller: addProductNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter product name ",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: addProductRateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Rate ",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
               keyboardType: TextInputType.number,
              controller: addProductGSTController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "GST%",
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
            "Submit",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          onPressed: onSubmit,
        ),
      ],
    );
  }
}
