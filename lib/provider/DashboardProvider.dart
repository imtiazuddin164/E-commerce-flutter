import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/Order.dart';
import 'package:flutter_ecommerce/service/DashboardService.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardService _service = DashboardService();

  // Summary Fields
  int totalProducts = 0;
  int stockAlerts = 0;
  num dailySales = 0;
  num monthlySales = 0;
  num yearlySales = 0;
  int newOrders = 0;

  // Tables & Charts
  List<Order> recentOrders = [];
  Map<String, num> barChartData = {};
  Map<String, int> pieChartData = {};

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadDashboardData() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Fetch data from API
      final products = await _service.fetchProducts();
      final orders = await _service.fetchOrders();

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Total Products
      totalProducts = products.length;

      // Stock Alerts
      // stockAlerts = products.where((p) => (p.stock ?? 0) < 5).length;
      stockAlerts = products.where((p) => (p.stock ?? 0) < 5 && p.stock != null).length;


      // Filter Orders
      final todayOrders = orders.where((o) =>
          o.date != null &&
          o.date!.year == today.year &&
          o.date!.month == today.month &&
          o.date!.day == today.day).toList();

      final monthOrders = orders.where((o) =>
          o.date != null &&
          o.date!.year == now.year &&
          o.date!.month == now.month).toList();

      final yearOrders = orders.where((o) =>
          o.date != null &&
          o.date!.year == now.year).toList();

      // Daily, Monthly, Yearly Sales (sum of item price)
      dailySales = todayOrders
          .expand((o) => o.items ?? [])
          .fold(0, (sum, item) => sum + (item.price ?? 0));

      monthlySales = monthOrders
          .expand((o) => o.items ?? [])
          .fold(0, (sum, item) => sum + (item.price ?? 0));

      yearlySales = yearOrders
          .expand((o) => o.items ?? [])
          .fold(0, (sum, item) => sum + (item.price ?? 0));

      // New Orders (current month)
      newOrders = monthOrders.length;

      // Recent Orders (last 10 items)
      List<Order> tempRecentOrders = orders
          .expand((order) => order.items!.map((item) => Order(
                id: order.id,
                orderCode: order.orderCode,
                date: order.date,
                customerName: item.name,
                items: [item],
              )))
          .toList();

      tempRecentOrders.sort((a, b) => b.date!.compareTo(a.date!));
      recentOrders = tempRecentOrders.take(10).toList();

      // Bar Chart: product name -> qty sold (current month)
      barChartData = {};
      final monthItems = monthOrders.expand((o) => o.items ?? []).toList();
      for (var item in monthItems) {
        if (item.name != null) {
          barChartData[item.name!] =
              (barChartData[item.name!] ?? 0) + (item.quantity ?? 0);
        }
      }

      // Pie Chart: product name -> stock
      pieChartData = {for (var p in products) p.productName ?? 'Unknown': p.stock ?? 0};

    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
