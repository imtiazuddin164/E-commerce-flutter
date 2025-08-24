/* import 'package:flutter/material.dart';

class DailySalesPage extends StatefulWidget {
  const DailySalesPage({super.key});

  @override
  State<DailySalesPage> createState() => _DailySalesPageState();
}

class _DailySalesPageState extends State<DailySalesPage> {
  // Sample sales data
  List<Map<String, dynamic>> salesList = [
    {
      "name": "Product A",
      "quantity": 2,
      "price": 500,
      "total": 1000,
      "date": "2025-08-16",
      "time": "10:30 AM",
    },
    {
      "name": "Product B",
      "quantity": 1,
      "price": 1500,
      "total": 1500,
      "date": "2025-08-16",
      "time": "11:00 AM",
    },
  ];

  List<Map<String, dynamic>> filteredList = [];
  String search = "";

  @override
  void initState() {
    super.initState();
    filteredList = List.from(salesList);
  }

  void filterSales() {
    setState(() {
      filteredList = salesList.where((item) {
        final query = search.toLowerCase();
        return item["name"].toString().toLowerCase().contains(query) ||
            item["date"].toString().contains(query);
      }).toList();
    });
  }

  double get todaySales =>
      salesList.fold(0, (sum, item) => sum + item["total"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📅 Today's Sales Summary")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Total Sales & Search
            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 768;
                return Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Sales: BDT ${todaySales.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: isMobile ? double.infinity : 300,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search by product name or date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                        onChanged: (value) {
                          search = value;
                          filterSales();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // 📋 Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey.shade800,
                ),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                columns: const [
                  DataColumn(label: Text("Product")),
                  DataColumn(label: Text("Qty")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Total")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Time")),
                ],
                rows: filteredList
                    .map(
                      (item) => DataRow(
                        cells: [
                          DataCell(Text(item["name"].toString())),
                          DataCell(Text(item["quantity"].toString())),
                          DataCell(Text(item["price"].toString())),
                          DataCell(Text(item["total"].toString())),
                          DataCell(Text(item["date"].toString())),
                          DataCell(Text(item["time"].toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/SalesReport.dart';
import 'package:provider/provider.dart';
/* 
class SalesReportPage extends StatefulWidget {
  const SalesReportPage({super.key});

  @override
  State<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  final _monthlyCtrl = TextEditingController();
  final _yearlyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SalesReportProvider>().load());
  }

  @override
  void dispose() {
    _monthlyCtrl.dispose();
    _yearlyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<SalesReportProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('📊 Sales Summary Report')),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Summary cards - responsive
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _summaryCard(
                            'Daily Sales',
                            prov.todaySales,
                            screenWidth,
                            const Color.fromARGB(255, 11, 100, 91),
                          ),
                          _summaryCard(
                            'Monthly Sales',
                            prov.monthlySales,
                            screenWidth,
                            const Color.fromARGB(255, 161, 45, 45),
                          ),
                          _summaryCard(
                            'Yearly Sales',
                            prov.yearlySales,
                            screenWidth,
                            const Color.fromARGB(255, 180, 128, 50),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Top Selling
                      _sectionCard(
                        title: '🏆 Top Selling Products',
                        child: _topSellingList(prov),
                      ),
                      const SizedBox(height: 16),

                      // Today details
                      _sectionCard(
                        title: '📅 Daily Products Sales (Details)',
                        child: _detailsTable(prov.detailedTodayList),
                      ),
                      const SizedBox(height: 16),

                      // Monthly details with search
                      _sectionCard(
                        title: '🗓️ Monthly Products Sales (Details)',
                        headerAction: _responsiveSearchBox(
                          _monthlyCtrl,
                          prov.filterMonthly,
                          screenWidth,
                        ),
                        child: _detailsTable(prov.filteredMonthlyList),
                      ),
                      const SizedBox(height: 16),

                      // Yearly details with search
                      _sectionCard(
                        title: '📆 Yearly Products Sales (Details)',
                        headerAction: _responsiveSearchBox(
                          _yearlyCtrl,
                          prov.filterYearly,
                          screenWidth,
                        ),
                        child: _detailsTable(prov.filteredYearlyList),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _summaryCard(
    String title,
    double amount,
    double screenWidth,
    Color bgColor,
  ) {
    double cardWidth = screenWidth < 600 ? (screenWidth / 2) - 24 : 260;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            '৳ ${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
    Widget? headerAction,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              color: Colors.blue.shade50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (headerAction != null) headerAction,
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(12.0), child: child),
        ],
      ),
    );
  }

  Widget _topSellingList(SalesReportProvider prov) {
    if (prov.topSellingMedicines.isEmpty) {
      return const Text('No data');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prov.topSellingMedicines.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final e = prov.topSellingMedicines[i];
        return ListTile(
          dense: true,
          title: Text(e.key),
          trailing: Text('Qty: ${e.value}'),
        );
      },
    );
  }

  Widget _detailsTable(List<SalesItemDetail> items) {
    if (items.isEmpty) return const Text('No data');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
        columns: const [
          DataColumn(label: Text('Product')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Price (৳)')),
          DataColumn(label: Text('Total (৳)')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Time')),
        ],
        rows: items
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(Text(e.name)),
                  DataCell(Text(e.quantity.toString())),
                  DataCell(Text(e.price.toStringAsFixed(2))),
                  DataCell(Text(e.total.toStringAsFixed(2))),
                  DataCell(Text(e.date)),
                  DataCell(Text(e.time)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _responsiveSearchBox(
    TextEditingController controller,
    Function(String) onChanged,
    double screenWidth,
  ) {
    return SizedBox(
      width: screenWidth < 500 ? 180 : 280,
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search by name or date',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: onChanged,
      ),
    );
  }
} */

class SalesReportPage extends StatefulWidget {
  const SalesReportPage({super.key});

  @override
  State<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  final _monthlyCtrl = TextEditingController();
  final _yearlyCtrl = TextEditingController();
  final _dailyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SalesReportProvider>().load());
  }

  @override
  void dispose() {
    _monthlyCtrl.dispose();
    _yearlyCtrl.dispose();
    _dailyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<SalesReportProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('📊 Sales Summary Report')),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ✅ Summary cards - responsive
                  screenWidth < 600
                      ? Column(
                          children: [
                            _summaryCard(
                              'Daily Sales',
                              prov.todaySales,
                              screenWidth,
                              const Color.fromARGB(255, 11, 100, 91),
                            ),
                            const SizedBox(height: 12),
                            _summaryCard(
                              'Monthly Sales',
                              prov.monthlySales,
                              screenWidth,
                              const Color.fromARGB(255, 161, 45, 45),
                            ),
                            const SizedBox(height: 12),
                            _summaryCard(
                              'Yearly Sales',
                              prov.yearlySales,
                              screenWidth,
                              const Color.fromARGB(255, 180, 128, 50),
                            ),
                          ],
                        )
                      : Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _summaryCard(
                              'Daily Sales',
                              prov.todaySales,
                              screenWidth,
                              const Color.fromARGB(255, 11, 100, 91),
                            ),
                            _summaryCard(
                              'Monthly Sales',
                              prov.monthlySales,
                              screenWidth,
                              const Color.fromARGB(255, 161, 45, 45),
                            ),
                            _summaryCard(
                              'Yearly Sales',
                              prov.yearlySales,
                              screenWidth,
                              const Color.fromARGB(255, 180, 128, 50),
                            ),
                          ],
                        ),

                  const SizedBox(height: 20),

                  // 🏆 Top Selling
                  _sectionCard(
                    title: '🏆 Top Selling Products',
                    child: _topSellingList(prov),
                  ),
                  const SizedBox(height: 20),

                  // 📅 Daily details with search
                  _sectionCard(
                    title: '📅 Daily Products Sales (Details)',
                    headerAction: _responsiveSearchBox(
                      _dailyCtrl,
                      prov.filterDaily,
                      screenWidth,
                    ),
                    child: _detailsTable(prov.detailedTodayList),
                  ),
                  const SizedBox(height: 20),

                  // 🗓️ Monthly details with search
                  _sectionCard(
                    title: '🗓️ Monthly Products Sales (Details)',
                    headerAction: _responsiveSearchBox(
                      _monthlyCtrl,
                      prov.filterMonthly,
                      screenWidth,
                    ),
                    child: _detailsTable(prov.filteredMonthlyList),
                  ),
                  const SizedBox(height: 20),

                  // 📆 Yearly details with search
                  _sectionCard(
                    title: '📆 Yearly Products Sales (Details)',
                    headerAction: _responsiveSearchBox(
                      _yearlyCtrl,
                      prov.filterYearly,
                      screenWidth,
                    ),
                    child: _detailsTable(prov.filteredYearlyList),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget _summaryCard(
  //   String title,
  //   double amount,
  //   double screenWidth,
  //   Color bgColor,
  // ) {
  //   double cardWidth = screenWidth < 600 ? double.infinity : 260;

  //   return Container(
  //     width: cardWidth,
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: bgColor.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.shade300),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           '৳ ${amount.toStringAsFixed(2)}',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: bgColor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _summaryCard(
  String title,
  double amount,
  double screenWidth,
  Color bgColor,
) {
  double cardWidth = screenWidth < 600 ? double.infinity : 260;

  return Container(
    width: cardWidth,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center, // ✅ Center align
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center, // ✅ Text center
        ),
        const SizedBox(height: 8),
        Text(
          '৳ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: bgColor,
          ),
          textAlign: TextAlign.center, // ✅ Amount center
        ),
      ],
    ),
  );
}


  Widget _sectionCard({
    required String title,
    required Widget child,
    Widget? headerAction,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              color: Colors.blue.shade50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                if (headerAction != null) ...[
                  const SizedBox(height: 8),
                  headerAction,
                ],
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(12.0), child: child),
        ],
      ),
    );
  }

  Widget _topSellingList(SalesReportProvider prov) {
    if (prov.topSellingMedicines.isEmpty) {
      return const Text('No data');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prov.topSellingMedicines.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final e = prov.topSellingMedicines[i];
        return ListTile(
          dense: true,
          title: Text(e.key),
          trailing: Text('Qty: ${e.value}'),
        );
      },
    );
  }

  Widget _detailsTable(List<SalesItemDetail> items) {
    if (items.isEmpty) return const Text('No data');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
        columns: const [
          DataColumn(label: Text('Product')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Price (৳)')),
          DataColumn(label: Text('Total (৳)')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Time')),
        ],
        rows: items
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(Text(e.name)),
                  DataCell(Text(e.quantity.toString())),
                  DataCell(Text(e.price.toStringAsFixed(2))),
                  DataCell(Text(e.total.toStringAsFixed(2))),
                  DataCell(Text(e.date)),
                  DataCell(Text(e.time)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _responsiveSearchBox(
    TextEditingController controller,
    Function(String) onChanged,
    double screenWidth,
  ) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search by name or date',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

/* 
class DailySalesPage extends StatelessWidget {
  const DailySalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<SalesReportProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("📅 Daily Sales")),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Today's Sales: ৳ ${prov.todaySales.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 16),

                  // Details table
                  _detailsTable(prov.detailedTodayList),
                ],
              ),
            ),
    );
  }

  Widget _detailsTable(List<SalesItemDetail> items) {
    if (items.isEmpty) return const Text("No data");

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Price")),
          DataColumn(label: Text("Total")),
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Time")),
        ],
        rows: items
            .map(
              (e) => DataRow(cells: [
                DataCell(Text(e.name)),
                DataCell(Text(e.quantity.toString())),
                DataCell(Text(e.price.toStringAsFixed(2))),
                DataCell(Text(e.total.toStringAsFixed(2))),
                DataCell(Text(e.date)),
                DataCell(Text(e.time)),
              ]),
            )
            .toList(),
      ),
    );
  }
}
 */

// class DailySalesPage extends StatelessWidget {
//   const DailySalesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final prov = context.watch<SalesReportProvider>();

//     return Scaffold(
//       appBar: AppBar(title: const Text("📅 Daily Sales")),
//       body: FutureBuilder(
//         future: prov.fetchDailySales(),
//         builder: (context, snapshot) {
//           if (prov.loading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (prov.detailedTodayList.isEmpty) {
//             return const Center(child: Text("No data"));
//           }

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Text(
//                   "Today's Sales: ৳ ${prov.todaySales.toStringAsFixed(2)}",
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green),
//                 ),
//                 const SizedBox(height: 16),
//                 _detailsTable(prov.detailedTodayList),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _detailsTable(List<SalesItemDetail> items) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: const [
//           DataColumn(label: Text("Product")),
//           DataColumn(label: Text("Quantity")),
//           DataColumn(label: Text("Price")),
//           DataColumn(label: Text("Total")),
//           DataColumn(label: Text("Date")),
//           DataColumn(label: Text("Time")),
//         ],
//         rows: items
//             .map(
//               (e) => DataRow(cells: [
//                 DataCell(Text(e.name)),
//                 DataCell(Text(e.quantity.toString())),
//                 DataCell(Text(e.price.toStringAsFixed(2))),
//                 DataCell(Text(e.total.toStringAsFixed(2))),
//                 DataCell(Text(e.date)),
//                 DataCell(Text(e.time)),
//               ]),
//             )
//             .toList(),
//       ),
//     );
//   }
// }
