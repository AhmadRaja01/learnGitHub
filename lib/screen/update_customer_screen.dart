import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../api_models/customer_model.dart';
import '../api_service/customer_api_service.dart';

class UpdateCustomerScreen extends StatelessWidget {
  final AddCustomerModel customer;
  final int index;

  UpdateCustomerScreen({super.key, required this.customer, required this.index});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = customer.name ?? "";
    emailController.text = customer.email ?? "";
    phoneController.text = customer.contact ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: BackButton(color: Colors.white,),
        title:  Text("Update Customer",style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          myTextField("Name", nameController),
          myTextField("Email", emailController),
          myTextField("Phone", phoneController),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              var data = AddCustomerModel(
                name: nameController.text,
                email: emailController.text,
                contact: phoneController.text,
              );
              Provider.of<CustomerApiServices>(context, listen: false)
                  .updateCustomer(data, customer.id.toString(), index)
                  .then((c) {
                if (c) {
                  Fluttertoast.showToast(msg: "Customer updated");
                  Navigator.pop(context);
                }
              });
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  Widget myTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
