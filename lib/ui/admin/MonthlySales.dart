/* import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/SalesReport.dart';
import 'package:provider/provider.dart';


class MonthlySalesPage extends StatefulWidget {
  const MonthlySalesPage({super.key});

  @override
  State<MonthlySalesPage> createState() => _MonthlySalesPageState();
}

class _MonthlySalesPageState extends State<MonthlySalesPage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<SalesReportProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("🗓️ Monthly Sales")),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Monthly Sales: ৳ ${prov.monthlySales.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),

                  // Search box
                  SizedBox(
                    width: screenWidth < 500 ? double.infinity : 300,
                    child: TextField(
                      controller: _searchCtrl,
                      decoration: const InputDecoration(
                        hintText: "Search by product or date",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: prov.filterMonthly,
                    ),
                  ),

                  const SizedBox(height: 16),
                  _detailsTable(prov.filteredMonthlyList),
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