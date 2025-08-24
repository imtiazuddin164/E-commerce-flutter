import 'dart:convert';
import 'package:flutter_ecommerce/model/Order.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl = "http://localhost:8080/orders";

  Future<bool> submitOrder(Order order) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Order submission failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error submitting order: $e");
      return false;
    }
  }
}
