import 'dart:convert';
import 'package:flutter_ecommerce/model/Order.dart';
import 'package:flutter_ecommerce/model/Product.dart';
import 'package:http/http.dart' as http;

/* 
class DashboardService {
  final String productUrl = 'http://localhost:8080/product';
  final String orderUrl = 'http://localhost:8080/orders';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(productUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(orderUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
      
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
 */


// DashboardService.dart


class DashboardService {
  // Backend API URLs
  final String productUrl = 'http://localhost:8080/product';
  final String orderUrl = 'http://localhost:8080/orders';

  /// Fetch all products from backend
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(productUrl));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  /// Fetch all orders from backend
  Future<List<Order>> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(orderUrl));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }
}
