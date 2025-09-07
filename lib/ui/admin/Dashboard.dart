import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/DashboardProvider.dart';
import 'package:provider/provider.dart';

/* class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? touchedBarIndex;
  int? touchedPieIndex;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboardData(),
      child: Scaffold(
        //appBar: AppBar(title: const Text("Dashboard")),
        body: Consumer<DashboardProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _summaryCard(
                          "Total Products",
                          provider.totalProducts,
                        ),
                      ),
                      Expanded(
                        child: _summaryCard(
                          "Stock Alerts",
                          provider.stockAlerts,
                        ),
                      ),
                      Expanded(
                        child: _summaryCard(
                          "Monthly Sales",
                          provider.monthlySales.toInt(),
                        ),
                      ),
                      Expanded(
                        child: _summaryCard("New Orders", provider.newOrders),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Bar Chart
                  const Text("Monthly Sales", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 250, child: _buildBarChart(provider)),

                  const SizedBox(height: 20),

                  // Pie Chart
                  const Text(
                    "Stock Distribution",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 250, child: _buildPieChart(provider)),

                  const SizedBox(height: 20),

                  // Recent Orders Table
                  const Text("Recent Orders", style: TextStyle(fontSize: 18)),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text("Order ID")),
                      DataColumn(label: Text("Product")),
                      DataColumn(label: Text("Quantity")),
                      DataColumn(label: Text("Date")),
                    ],
                    rows: provider.recentOrders.map((order) {
                      final item = order.items!.first;
                      return DataRow(
                        cells: [
                          DataCell(Text(order.id.toString())),
                          DataCell(Text(item.name ?? 'Unknown')),
                          DataCell(Text(item.quantity.toString())),
                          DataCell(Text(order.date.toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _summaryCard(String title, int value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              "$value",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(DashboardProvider provider) {
    final keys = provider.barChartData.keys.toList();
    final values = provider.barChartData.values.toList();

    return BarChart(
      BarChartData(
        maxY:
            (values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 10)
                .toDouble() +
            5,
        barGroups: List.generate(keys.length, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: values[i].toDouble(),
                color: touchedBarIndex == i ? Colors.orange : Colors.blue,
                width: 18,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
            showingTooltipIndicators: touchedBarIndex == i ? [0] : [],
          );
        }),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= keys.length) return const SizedBox();
                // return SideTitleWidget(
                //   axisSide: meta.axisSide,
                //   child: Text(
                //     keys[index],
                //     style: const TextStyle(fontSize: 10),
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // );
                return SideTitleWidget(
                  meta:
                      meta, 
                  child: Text(
                    keys[index],
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              reservedSize: 42,
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 1),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${keys[group.x.toInt()]}\nQty Sold: ${rod.toY.toInt()}',
                const TextStyle(color: Colors.white),
              );
            },
          ),

          touchCallback: (event, response) {
            if (response == null || response.spot == null) {
              setState(() {
                touchedBarIndex = null;
              });
              return;
            }
            setState(() {
              touchedBarIndex = response.spot!.touchedBarGroupIndex;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPieChart(DashboardProvider provider) {
    final entries = provider.pieChartData.entries.toList();

    return PieChart(
      PieChartData(
        sections: List.generate(entries.length, (i) {
          final e = entries[i];
          final isTouched = touchedPieIndex == i;
          //final double radius = isTouched ? 60 : 50;
          final double radius = isTouched ? 100 : 80;
          final color = Colors.primaries[i % Colors.primaries.length];

          return PieChartSectionData(
            color: color,
            value: e.value.toDouble(),
            title: '${e.key}\n${e.value}',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titlePositionPercentageOffset: 0.5,
            badgeWidget: isTouched ? _badge(e.key) : null,
            badgePositionPercentageOffset: 1.1,
          );
        }),
        pieTouchData: PieTouchData(
          touchCallback: (event, response) {
            if (response == null || response.touchedSection == null) {
              setState(() {
                touchedPieIndex = null;
              });
              return;
            }
            setState(() {
              touchedPieIndex = response.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
 */

// static design

/* import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Heading
          const Text(
            "👋 Welcome, Admin",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 25),

          /// First Row: Daily, Monthly, Yearly Sales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              summaryCard("Daily Sales", "৳ 12,500", Colors.teal),
              summaryCard("Monthly Sales", "৳ 320,000", Colors.teal),
              summaryCard("Yearly Sales", "৳ 4,200,000", Colors.teal),
            ],
          ),
          const SizedBox(height: 20),

          /// Second Row: Total Products, New Orders, Stock Alerts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              summaryCard("Total Products", "120", Colors.grey.shade200,
                  textColor: Colors.teal.shade800),
              summaryCard("New Orders", "35", Colors.grey.shade200,
                  textColor: Colors.teal.shade800),
              summaryCard("Stock Alerts", "5", Colors.grey.shade200,
                  textColor: Colors.teal.shade800),
            ],
          ),
          const SizedBox(height: 30),

          /// Dashboard Panels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dashboardPanel(
                "⏳ Pending Sellers",
                ["Rafiul Tech", "Mazhar Electronics", "Ayesha Fashion"],
                buttonText: "View All",
              ),
              dashboardPanel(
                "🕒 Recent Orders",
                [
                  "Order #1023 — ৳230 — 📦 Delivered",
                  "Order #1024 — ৳340 — ⏳ Processing",
                  "Order #1025 — ৳90 — ❌ Cancelled"
                ],
                buttonText: "View All",
              ),
              dashboardPanel(
                "⚠️ Low Stock Alerts",
                ["iPhone 13 — 3 left", "Samsung TV — 5 left"],
                buttonText: "Restock Now",
              ),
            ],
          ),
          const SizedBox(height: 30),

          /// Recent Orders Table
          const Text(
            "📋 Recent Orders Table",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 10),
          recentOrdersTable(),
        ],
      ),
    );
  }

  /// Summary Card Widget
  Widget summaryCard(String title, String value, Color bgColor,
      {Color textColor = Colors.white}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              const SizedBox(height: 10),
              Text(value,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  /// Dashboard Panel Widget
  Widget dashboardPanel(String title, List<String> items, {String? buttonText}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40))),
              const SizedBox(height: 12),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(item,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black87)),
                  )),
              const SizedBox(height: 10),
              if (buttonText != null)
                TextButton(
                  onPressed: () {},
                  child: Text(buttonText,
                      style: const TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Recent Orders Table
  Widget recentOrdersTable() {
    final recentOrders = [
      {"id": 1023, "products": "Samsung Galaxy S25", "quantity": 2, "date": "12-08-2025"},
      {"id": 1024, "products": "Google Pixel 9 pro XL", "quantity": 1, "date": "13-08-2025"},
      {"id": 1025, "products": "Apple iPhone 15 pro ", "quantity": 3, "date": "14-08-2025"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Order ID")),
          DataColumn(label: Text("Products")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Date")),
        ],
        rows: recentOrders
            .map((order) => DataRow(
                  cells: [
                    DataCell(Text(order["id"].toString())),
                    DataCell(Text(order["products"].toString())),
                    DataCell(Text(order["quantity"].toString())),
                    DataCell(Text(order["date"].toString())),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
 */

/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecommerce/provider/DashboardProvider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false)
          .loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Consumer<DashboardProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Heading
                const Text(
                  "👋 Welcome, Admin",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D40),
                  ),
                ),
                const SizedBox(height: 25),

                /// First Row: Daily, Monthly, Yearly Sales (Dynamic)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    summaryCard("Daily Sales", "৳ ${provider.monthlySales}", Colors.teal),
                    summaryCard("Monthly Sales", "৳ ${provider.monthlySales}", Colors.teal),
                    summaryCard("Yearly Sales", "৳ ${provider.monthlySales * 12}", Colors.teal),
                  ],
                ),
                const SizedBox(height: 20),

                /// Second Row: Total Products, New Orders, Stock Alerts (Dynamic)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    summaryCard("Total Products", "${provider.totalProducts}", Colors.grey.shade200,
                        textColor: Colors.teal.shade800),
                    summaryCard("New Orders", "${provider.newOrders}", Colors.grey.shade200,
                        textColor: Colors.teal.shade800),
                    summaryCard("Stock Alerts", "${provider.stockAlerts}", Colors.grey.shade200,
                        textColor: Colors.teal.shade800),
                  ],
                ),
                const SizedBox(height: 30),

                /// Dashboard Panels (Dynamic)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dashboardPanel(
                      "⏳ Pending Sellers",
                      ["Rafiul Tech", "Mazhar Electronics", "Ayesha Fashion"],
                      buttonText: "View All",
                    ),
                    dashboardPanel(
                      "🕒 Recent Orders",
                      provider.recentOrders
                          .map((order) =>
                              "Order #${order.id} — Qty: ${order.items!.first.quantity} — 📦 ${order.items!.first.name}")
                          .toList(),
                      buttonText: "View All",
                    ),
                    dashboardPanel(
                      "⚠️ Low Stock Alerts",
                      provider.pieChartData.entries
                          .where((e) => e.value < 5)
                          .map((e) => "${e.key} — ${e.value} left")
                          .toList(),
                      buttonText: "Restock Now",
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                /// Recent Orders Table (Dynamic)
                const Text(
                  "📋 Recent Orders Table",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D40),
                  ),
                ),
                const SizedBox(height: 10),
                recentOrdersTable(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Summary Card Widget
  Widget summaryCard(String title, String value, Color bgColor,
      {Color textColor = Colors.white}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              Text(value,
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  /// Dashboard Panel Widget
  Widget dashboardPanel(String title, List<String> items, {String? buttonText}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              const SizedBox(height: 12),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child:
                        Text(item, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  )),
              const SizedBox(height: 10),
              if (buttonText != null)
                TextButton(
                  onPressed: () {},
                  child: Text(buttonText,
                      style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Recent Orders Table
  Widget recentOrdersTable(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Order ID")),
          DataColumn(label: Text("Products")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Date")),
        ],
        rows: provider.recentOrders
            .map(
              (order) => DataRow(
                cells: [
                  DataCell(Text(order.id.toString())),
                  DataCell(Text(order.items!.first.name ?? 'Unknown')),
                  DataCell(Text(order.items!.first.quantity.toString())),
                  DataCell(Text(order.date.toString().split(' ')[0])),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
 */

/* 
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data on page load
    Future.microtask(() =>
        Provider.of<DashboardProvider>(context, listen: false)
            .loadDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const Text(
                "👋 Welcome, Admin",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 25),

              // First Row: Daily, Monthly, Yearly Sales
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  summaryCard(
                      "Daily Sales", "৳ ${provider.dailySales}", Colors.teal),
                  summaryCard("Monthly Sales",
                      "৳ ${provider.monthlySales}", Colors.teal),
                  summaryCard(
                      "Yearly Sales", "৳ ${provider.yearlySales}", Colors.teal),
                ],
              ),
              const SizedBox(height: 20),

              // Second Row: Total Products, New Orders, Stock Alerts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  summaryCard("Total Products", "${provider.totalProducts}",
                      Colors.grey.shade200,
                      textColor: Colors.teal.shade800),
                  summaryCard("New Orders", "${provider.newOrders}",
                      Colors.grey.shade200,
                      textColor: Colors.teal.shade800),
                  summaryCard("Stock Alerts", "${provider.stockAlerts}",
                      Colors.grey.shade200,
                      textColor: Colors.teal.shade800),
                ],
              ),
              const SizedBox(height: 30),

              // Dashboard Panels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dashboardPanel(
                    "⏳ Pending Sellers",
                    ["Rafiul Tech", "Mazhar Electronics", "Ayesha Fashion"],
                    buttonText: "View All",
                  ),
                  dashboardPanel(
                    "🕒 Recent Orders",
                    provider.recentOrders
                        .map((o) =>
                            "Order #${o.id} — ৳${o.items![0].price} — ${o.items![0].name}")
                        .toList(),
                    buttonText: "View All",
                  ),
                  dashboardPanel(
                    "⚠️ Low Stock Alerts",
                    provider.pieChartData.entries
                        .where((e) => e.value < 5)
                        .map((e) => "${e.key} — ${e.value} left")
                        .toList(),
                    buttonText: "Restock Now",
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Recent Orders Table
              const Text(
                "📋 Recent Orders Table",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 10),
              recentOrdersTable(provider),
            ],
          ),
        );
      },
    );
  }

  // Summary Card Widget
  Widget summaryCard(String title, String value, Color bgColor,
      {Color textColor = Colors.white}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              const SizedBox(height: 10),
              Text(value,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  // Dashboard Panel Widget
  Widget dashboardPanel(String title, List<String> items, {String? buttonText}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40))),
              const SizedBox(height: 12),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(item,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black87)),
                  )),
              const SizedBox(height: 10),
              if (buttonText != null)
                TextButton(
                  onPressed: () {},
                  child: Text(buttonText,
                      style: const TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Recent Orders Table
  Widget recentOrdersTable(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Order ID")),
          DataColumn(label: Text("Products")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Date")),
        ],
        rows: provider.recentOrders
            .map((order) => DataRow(
                  cells: [
                    DataCell(Text(order.id.toString())),
                    DataCell(Text(order.items![0].name ?? "")),
                    DataCell(Text(order.items![0].quantity.toString())),
                    DataCell(Text(order.date.toString().split(" ")[0])),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
 */

/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget summaryCard(String title, String value, Color bgColor, {Color textColor = Colors.white}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboardData(),
      builder: (context, child) {
        return Scaffold(
          body: Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Heading
                    const Text(
                      "👋 Welcome, Admin",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004D40),
                      ),
                    ),
                    const SizedBox(height: 25),

                    /// First Row: Daily, Monthly, Yearly Sales
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        summaryCard("Daily Sales", "৳ ${provider.dailySales}", Colors.teal),
                        summaryCard("Monthly Sales", "৳ ${provider.monthlySales}", Colors.teal),
                        summaryCard("Yearly Sales", "৳ ${provider.yearlySales}", Colors.teal),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Second Row: Total Products, New Orders, Stock Alerts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        summaryCard("Total Products", "${provider.totalProducts}", Colors.grey.shade200, textColor: Colors.teal.shade800),
                        summaryCard("New Orders", "${provider.newOrders}", Colors.grey.shade200, textColor: Colors.teal.shade800),
                        summaryCard("Stock Alerts", "${provider.stockAlerts}", Colors.grey.shade200, textColor: Colors.teal.shade800),
                      ],
                    ),

                    // ... baki panel & table section
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // summaryCard() & dashboardPanel() functions এখানে আগের মতোই থাকবে
  Widget recentOrdersTable(DashboardProvider provider) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: const [
        DataColumn(label: Text("Order ID")),
        DataColumn(label: Text("Products")),
        DataColumn(label: Text("Quantity")),
        DataColumn(label: Text("Date")),
      ],
      rows: provider.recentOrders
          .map((order) => DataRow(
                cells: [
                  DataCell(Text(order.id.toString())),
                  DataCell(Text(order.items!.first.name ?? 'Unknown')),
                  DataCell(Text(order.items!.first.quantity.toString())),
                  DataCell(Text(order.date.toString())),
                ],
              ))
          .toList(),
    ),
  );
}

}
 */

/* class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  /// Summary Card Widget
  Widget summaryCard(String title, String value, Color bgColor, {Color textColor = Colors.white}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  /// Recent Orders Table Widget
  Widget recentOrdersTable(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Order ID")),
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Date")),
        ],
        rows: provider.recentOrders
            .map((order) => DataRow(
                  cells: [
                    DataCell(Text(order.id.toString())),
                    DataCell(Text(order.items!.first.name ?? 'Unknown')),
                    DataCell(Text(order.items!.first.quantity.toString())),
                    DataCell(Text(order.date != null ? "${order.date!.day}-${order.date!.month}-${order.date!.year}" : '')),
                  ],
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboardData(),
      builder: (context, child) {
        return Scaffold(
          body: Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Heading
                    const Text(
                      "👋 Welcome, Admin",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                    ),
                    const SizedBox(height: 25),

                    /// First Row: Daily, Monthly, Yearly Sales
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        summaryCard("Daily Sales", "৳ ${provider.dailySales}", Colors.teal),
                        summaryCard("Monthly Sales", "৳ ${provider.monthlySales}", Colors.teal),
                        summaryCard("Yearly Sales", "৳ ${provider.yearlySales}", Colors.teal),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Second Row: Total Products, New Orders, Stock Alerts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        summaryCard("Total Products", "${provider.totalProducts}", Colors.grey.shade200, textColor: Colors.teal.shade800),
                        summaryCard("New Orders", "${provider.newOrders}", Colors.grey.shade200, textColor: Colors.teal.shade800),
                        summaryCard("Stock Alerts", "${provider.stockAlerts}", Colors.grey.shade200, textColor: Colors.teal.shade800),
                      ],
                    ),
                    const SizedBox(height: 30),

                    /// Recent Orders Table
                    const Text(
                      "📋 Recent Orders Table",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                    ),
                    const SizedBox(height: 10),
                    recentOrdersTable(provider),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
 */

/* class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  /// Summary Card Widget
  Widget summaryCard(String title, String value, Color bgColor,
      {Color textColor = Colors.white}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 10),
            Text(value,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
          ],
        ),
      ),
    );
  }

  /// Recent Orders Table Widget
  Widget recentOrdersTable(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Order ID")),
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Date")),
        ],
        rows: provider.recentOrders
            .map((order) => DataRow(
                  cells: [
                    DataCell(Text(order.id.toString())),
                    DataCell(Text(order.items!.first.name ?? 'Unknown')),
                    DataCell(Text(order.items!.first.quantity.toString())),
                    DataCell(Text(order.date != null
                        ? "${order.date!.day}-${order.date!.month}-${order.date!.year}"
                        : '')),
                  ],
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboardData(),
      builder: (context, child) {
        return Scaffold(
          body: Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Heading
                    const Text(
                      "👋 Welcome, Admin",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004D40)),
                    ),
                    const SizedBox(height: 25),

                    /// First Row: Daily, Monthly, Yearly Sales (Responsive)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          // Small screen (mobile) -> Column
                          return Column(
                            children: [
                              summaryCard(
                                  "Daily Sales", "৳ ${provider.dailySales}", Colors.teal),
                              const SizedBox(height: 12),
                              summaryCard(
                                  "Monthly Sales", "৳ ${provider.monthlySales}", Colors.teal),
                              const SizedBox(height: 12),
                              summaryCard(
                                  "Yearly Sales", "৳ ${provider.yearlySales}", Colors.teal),
                            ],
                          );
                        } else {
                          // Large screen -> Row
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: summaryCard("Daily Sales",
                                      "৳ ${provider.dailySales}", Colors.teal)),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: summaryCard("Monthly Sales",
                                      "৳ ${provider.monthlySales}", Colors.teal)),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: summaryCard("Yearly Sales",
                                      "৳ ${provider.yearlySales}", Colors.teal)),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    /// Second Row: Total Products, New Orders, Stock Alerts (Responsive)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Column(
                            children: [
                              summaryCard("Total Products",
                                  "${provider.totalProducts}", Colors.grey.shade200,
                                  textColor: Colors.teal.shade800),
                              const SizedBox(height: 12),
                              summaryCard("New Orders", "${provider.newOrders}",
                                  Colors.grey.shade200,
                                  textColor: Colors.teal.shade800),
                              const SizedBox(height: 12),
                              summaryCard("Stock Alerts", "${provider.stockAlerts}",
                                  Colors.grey.shade200,
                                  textColor: Colors.teal.shade800),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: summaryCard("Total Products",
                                      "${provider.totalProducts}", Colors.grey.shade200,
                                      textColor: Colors.teal.shade800)),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: summaryCard("New Orders", "${provider.newOrders}",
                                      Colors.grey.shade200,
                                      textColor: Colors.teal.shade800)),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: summaryCard("Stock Alerts",
                                      "${provider.stockAlerts}", Colors.grey.shade200,
                                      textColor: Colors.teal.shade800)),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 30),

                    /// Recent Orders Table
                    const Text(
                      "📋 Recent Orders Table",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004D40)),
                    ),
                    const SizedBox(height: 10),
                    recentOrdersTable(provider),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
 */

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  /// Summary Card Widget
  Widget summaryCard(
    String title,
    String value,
    Color bgColor, {
    Color textColor = Colors.white,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Recent Orders Table Widget
  Widget recentOrdersTable(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Order ID")),
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Date")),
        ],
        rows: provider.recentOrders
            .map(
              (order) => DataRow(
                cells: [
                  DataCell(Text(order.id.toString())),
                  DataCell(Text(order.items!.first.name ?? 'Unknown')),
                  DataCell(Text(order.items!.first.quantity.toString())),
                  DataCell(
                    Text(
                      order.date != null
                          ? "${order.date!.day}-${order.date!.month}-${order.date!.year}"
                          : '',
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider()..loadDashboardData(),
      builder: (context, child) {
        return Scaffold(
          body: Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Heading
                    const Text(
                      "👋 Welcome, Admin",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004D40),
                      ),
                    ),
                    const SizedBox(height: 25),

                    /// First Row: Daily, Monthly, Yearly Sales (Responsive using Wrap)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double cardWidth = constraints.maxWidth < 600
                            ? double.infinity
                            : (constraints.maxWidth - 24) / 3;

                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: cardWidth,
                              child: summaryCard(
                                "Daily Sales",
                                "৳ ${provider.dailySales}",
                                Colors.teal,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: summaryCard(
                                "Monthly Sales",
                                "৳ ${provider.monthlySales}",
                                Colors.teal,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: summaryCard(
                                "Yearly Sales",
                                "৳ ${provider.yearlySales}",
                                Colors.teal,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    /// Second Row: Total Products, New Orders, Stock Alerts (Responsive using Wrap)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double cardWidth = constraints.maxWidth < 600
                            ? double.infinity
                            : (constraints.maxWidth - 24) / 3;

                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: cardWidth,
                              child: summaryCard(
                                "Total Products",
                                "${provider.totalProducts}",
                                Colors.grey.shade200,
                                textColor: Colors.teal.shade800,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: summaryCard(
                                "New Orders",
                                "${provider.newOrders}",
                                Colors.grey.shade200,
                                textColor: Colors.teal.shade800,
                              ),
                            ),
                            SizedBox(
                              width: cardWidth,
                              child: summaryCard(
                                "Stock Alerts",
                                "${provider.stockAlerts}",
                                Colors.grey.shade200,
                                textColor: Colors.teal.shade800,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),

                    /// Recent Orders Table
                    const Text(
                      "📋 Recent Orders Table",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004D40),
                      ),
                    ),
                    const SizedBox(height: 10),
                    recentOrdersTable(provider),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
