import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../api_models/customer_model.dart';

class CustomerApiServices extends ChangeNotifier {
  List<AddCustomerModel> customers = [];

  final String _baseURL = "https://api.razorpay.com/v1/";
  final String _key = "rzp_test_fDHQt7hg7IlYBv";
  final String _secretKey = "SzSUd2fe3n5NO8KragWwfKsc";
  final String _customerEndPoint = "customers";

  Map<String, String> _headers() => {
    "Authorization": 'Basic ' + base64Encode(utf8.encode('$_key:$_secretKey')),
  };

  Future<bool> addNewCustomer(AddCustomerModel data) async {
    var url = Uri.parse(_baseURL + _customerEndPoint);
    var response = await http.post(url, headers: _headers(), body: data.toJson());
    if (response.statusCode == 200) {
      customers.add(data);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateCustomer(AddCustomerModel data, String id, int index) async {
    var url = Uri.parse(_baseURL + _customerEndPoint + "/$id");
    var response = await http.put(url, headers: _headers(), body: data.toJson());
    if (response.statusCode == 200) {
      customers[index] = data;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> getCustomers() async {
    var url = Uri.parse(_baseURL + _customerEndPoint);
    var response = await http.get(url, headers: _headers());
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      var items = CustomersModel.fromJson(resData).items ?? [];
      customers = items.map((customer) {
        return AddCustomerModel(
          name: customer.name,
          contact: customer.contact,
          email: customer.email,
          id: customer.id,
        );
      }).toList();
      notifyListeners();
    }
  }
}
