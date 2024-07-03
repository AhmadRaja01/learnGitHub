import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../api_models/customer_model.dart';
import '../api_service/customer_api_service.dart';

class AddCustomerScreen extends StatelessWidget {
  AddCustomerScreen({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.purple,
        title:  Text("Add Customer",style: TextStyle(color: Colors.white),),
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
                  .addNewCustomer(data)
                  .then((c) {
                if (c) {
                  Fluttertoast.showToast(msg: "Customer added");
                  Navigator.pop(context);
                }
              });
            },
            child: const Text("Add"),
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
