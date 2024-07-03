import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api_service/customer_api_service.dart';
import 'add_customer_screen.dart';
import 'update_customer_screen.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CustomerApiServices>(context, listen: false).getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddCustomerScreen()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: BackButton(color: Colors.white,),
        title: const Text("Customers Api ( R - Pay )",style: TextStyle(color: Colors.white),),
      ),
      body: Consumer<CustomerApiServices>(
        builder: (context, value, child) {
          var customers = value.customers;
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Text("Name: ${customers[index].name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: ${customers[index].email}"),
                      Text("Phone: ${customers[index].contact}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateCustomerScreen(
                            customer: customers[index],
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
