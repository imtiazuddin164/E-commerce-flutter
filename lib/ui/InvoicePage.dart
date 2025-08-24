// import 'package:flutter/material.dart';

// class InvoicePage extends StatelessWidget {
//   final List<Map<String, dynamic>> cartItems = [
//     {
//       'name': 'Product 1',
//       'image': 'assets/product1.png',
//       'qty': 2,
//       'price': 300,
//     },
//     {
//       'name': 'Product 2',
//       'image': 'assets/product2.png',
//       'qty': 1,
//       'price': 500,
//     },
//   ];

//   final String customerName = "Imtiaz Uddin";
//   final String phone = "017xxxxxxxx";
//   final String address = "Feni, Bangladesh";

//   final int discount = 100;
//   final int deliveryCharge = 50;
//   final String paymentMethod = "Cash on Delivery";

//   @override
//   Widget build(BuildContext context) {
//     int subtotal = cartItems.fold(0, (sum, item) => sum + (item['qty'] * item['price']) as int);
//     int total = subtotal - discount + deliveryCharge;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🧾 Invoice"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // Invoice Header
//             Text("Invoice No: INV123456", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Date: 08 Aug 2025\n", style: TextStyle(color: Colors.grey[700])),

//             // Customer Info
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("👤 $customerName"),
//                     Text("📞 $phone"),
//                     Text("📍 $address"),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Product List
//             Text("🛍️ Purchased Items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             ...cartItems.map((item) => Card(
//                   child: ListTile(
//                     leading: Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
//                     title: Text(item['name']),
//                     subtitle: Text("Quantity: ${item['qty']}"),
//                     trailing: Text("৳${item['qty'] * item['price']}"),
//                   ),
//                 )),

//             const SizedBox(height: 20),

//             // Summary
//             Divider(),
//             summaryRow("Subtotal", subtotal),
//             summaryRow("Discount", -discount),
//             summaryRow("Delivery Charge", deliveryCharge),
//             Divider(thickness: 1.5),
//             summaryRow("Total", total, isTotal: true),
//             const SizedBox(height: 12),

//             // Payment Method
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("💳 Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text(paymentMethod),
//               ],
//             ),
//             const SizedBox(height: 20),

//             Center(
//               child: Text("✅ Thank you for your purchase!",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget summaryRow(String label, int amount, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
//           Text("৳$amount", style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
//         ],
//       ),
//     );
//   }
// }

/*
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Product 1',
      'qty': 2,
      'price': 300,
    },
    {
      'name': 'Product 2',
      'qty': 1,
      'price': 500,
    },
  ];

  final String customerName = "Imtiaz Uddin";
  final String phone = "017xxxxxxxx";
  final String address = "Feni, Bangladesh";

  final int discount = 100;
  final int deliveryCharge = 50;
  final String paymentMethod = "Cash on Delivery";

  @override
  Widget build(BuildContext context) {
    int subtotal = cartItems.fold(0, (sum, item) => (sum + item['qty'] * item['price']) as int);
    int total = subtotal - discount + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text("🧾 Invoice"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf();
              await Printing.layoutPdf(onLayout: (format) => pdf.save());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Invoice No: INV123456", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Date: 08 Aug 2025\n", style: TextStyle(color: Colors.grey[700])),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("👤 $customerName"),
                    Text("📞 $phone"),
                    Text("📍 $address"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text("🛍️ Purchased Items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...cartItems.map((item) => ListTile(
                  title: Text(item['name']),
                  subtitle: Text("Quantity: ${item['qty']}"),
                  trailing: Text("৳${item['qty'] * item['price']}"),
                )),

            const SizedBox(height: 20),
            Divider(),
            summaryRow("Subtotal", subtotal),
            summaryRow("Discount", -discount),
            summaryRow("Delivery Charge", deliveryCharge),
            Divider(thickness: 1.5),
            summaryRow("Total", total, isTotal: true),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("💳 Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(paymentMethod),
              ],
            ),
            const SizedBox(height: 20),

            Center(
              child: Text("✅ Thank you for your purchase!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, int amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text("৳$amount", style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    int subtotal = cartItems.fold(0, (sum, item) => (sum + item['qty'] * item['price']) as int);
    int total = subtotal - discount + deliveryCharge;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("🧾 Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Invoice No: INV123456"),
            pw.Text("Date: 08 Aug 2025"),
            pw.SizedBox(height: 10),
            pw.Text("👤 $customerName"),
            pw.Text("📞 $phone"),
            pw.Text("📍 $address"),
            pw.SizedBox(height: 20),
            pw.Text("🛍️ Items:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            ...cartItems.map((item) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("${item['name']} x${item['qty']}"),
                    pw.Text("৳${item['qty'] * item['price']}"),
                  ],
                )),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [pw.Text("Subtotal"), pw.Text("৳$subtotal")],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [pw.Text("Discount"), pw.Text("-৳$discount")],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [pw.Text("Delivery Charge"), pw.Text("৳$deliveryCharge")],
            ),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("৳$total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text("💳 Payment Method: $paymentMethod"),
            pw.SizedBox(height: 20),
            pw.Center(
              child: pw.Text("✅ Thank you for your purchase!",
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            )
          ],
        ),
      ),
    );

    return pdf;
  }
}
*/

//with date and time

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
//Working Main code

/* class InvoicePage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;
  final Map<String, dynamic> paymentInfo;
  final double deliveryFee;
  final double subtotal;
  final double vat;
  final DateTime orderDate;
  final String orderCode; 

  const InvoicePage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
    required this.paymentInfo,
    required this.deliveryFee,
    required this.subtotal,
    required this.vat,
    required this.orderDate, 
    required this.orderCode,
    
  });

  double get totalAmount => subtotal + vat + deliveryFee;

  String get formattedDate {
    return DateFormat('dd MMM yyyy, hh:mm a').format(orderDate);
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("🧾 Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text("🗓️ Date & Time: $formattedDate", style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              pw.Text("Order Code: $orderCode", style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              // Delivery Info
              pw.Text("🚚 Delivery Information:", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Name: ${deliveryInfo['customerName']}"),
              pw.Text("Address: ${deliveryInfo['address']}"),
              pw.Text("Phone: ${deliveryInfo['phone']}"),
              pw.SizedBox(height: 20),

              // Payment Info
              pw.Text("💳 Payment Details:", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Method: ${paymentInfo['method']}"),
              if (paymentInfo['mobileType'] != null && paymentInfo['mobileType'].toString().isNotEmpty)
                pw.Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
              if (paymentInfo['transactionId'] != null && paymentInfo['transactionId'].toString().isNotEmpty)
                pw.Text("Transaction ID: ${paymentInfo['transactionId']}"),
              if (paymentInfo['cardName'] != null && paymentInfo['cardName'].toString().isNotEmpty)
                pw.Text("Cardholder Name: ${paymentInfo['cardName']}"),
              if (paymentInfo['cardNumber'] != null && paymentInfo['cardNumber'].toString().isNotEmpty)
                pw.Text("Card Number: ${paymentInfo['cardNumber']}"),
              pw.SizedBox(height: 20),

              // Ordered Items
              pw.Text("📦 Ordered Items:", style: pw.TextStyle(fontSize: 18)),
              pw.Table.fromTextArray(
                headers: ["Medicine", "Qty", "Price"],
                data: cartItems.map((item) => [
                      item['name'],
                      item['quantity'].toString(),
                      "৳${item['price']}",
                    ]).toList(),
              ),
              pw.SizedBox(height: 20),

              // Totals
              pw.Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
              pw.Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
              pw.Text("Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}"),
              pw.Text("Total: ৳${totalAmount.toStringAsFixed(2)}", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdf(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("🗓️ Order Date & Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(formattedDate),
            const SizedBox(height: 20),

            //const Text(" Order Code : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(" Order Code : $orderCode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),

            const Text("🚚 Delivery Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Name: ${deliveryInfo['customerName']}"),
            const SizedBox(height: 5),
            Text("Address: ${deliveryInfo['address']}"),
            const SizedBox(height: 5),
            Text("Phone: ${deliveryInfo['phone']}"),
            const Divider(),

            const SizedBox(height: 10),
            const Text("💳 Payment Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("Method: ${paymentInfo['method']}"),
            const SizedBox(height: 5),
            if (paymentInfo['mobileType'] != null && paymentInfo['mobileType'].toString().isNotEmpty)
              Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
              const SizedBox(height: 5),
            if (paymentInfo['transactionId'] != null && paymentInfo['transactionId'].toString().isNotEmpty)
              Text("Transaction ID: ${paymentInfo['transactionId']}"),
            if (paymentInfo['cardName'] != null && paymentInfo['cardName'].toString().isNotEmpty)
              Text("Cardholder Name: ${paymentInfo['cardName']}"),
              const SizedBox(height: 5),
            if (paymentInfo['cardNumber'] != null && paymentInfo['cardNumber'].toString().isNotEmpty)
              Text("Card Number: ${paymentInfo['cardNumber']}"),
            const Divider(),

            const SizedBox(height: 10),
            const Text("📦 Ordered Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.teal),
                  children: [
                    Padding(padding: EdgeInsets.all(8.0), child: Text("Medicine", style: TextStyle(color: Colors.white))),
                    Padding(padding: EdgeInsets.all(8.0), child: Text("Qty", style: TextStyle(color: Colors.white))),
                    Padding(padding: EdgeInsets.all(8.0), child: Text("Price", style: TextStyle(color: Colors.white))),
                  ],
                ),
                ...cartItems.map((item) => TableRow(children: [
                      Padding(padding: const EdgeInsets.all(8.0), child: Text(item['name'])),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text(item['quantity'].toString())),
                      Padding(padding: const EdgeInsets.all(8.0), child: Text("৳${item['price']}")),
                    ])),
              ],
            ),

            const SizedBox(height: 10),
            Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            Text("Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            Text("Total: ৳${totalAmount.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => _generatePdf(context),
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text("Download PDF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
 */

class InvoicePage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;
  final Map<String, dynamic> paymentInfo;
  final double deliveryFee;
  final double subtotal;
  final double vat;
  final DateTime orderDate;
  final String orderCode;

  const InvoicePage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
    required this.paymentInfo,
    required this.deliveryFee,
    required this.subtotal,
    required this.vat,
    required this.orderDate,
    required this.orderCode,
  });

  double get totalAmount => subtotal + vat + deliveryFee;

  String get formattedDate {
    return DateFormat('dd MMM yyyy, hh:mm a').format(orderDate);
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context ctx) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    "INVOICE",
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),

                // Order Info
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Order Code: $orderCode",
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      "Date: $formattedDate",
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                // Delivery Info
                pw.Text(
                  "Delivery Information",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text("Name: ${deliveryInfo['customerName']}"),
                pw.Text("Address: ${deliveryInfo['address']}"),
                pw.Text("Phone: ${deliveryInfo['phone']}"),
                pw.SizedBox(height: 20),

                // Payment Info
                pw.Text(
                  "Payment Details",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text("Method: ${paymentInfo['method']}"),
                if (paymentInfo['mobileType'] != null &&
                    paymentInfo['mobileType'].toString().isNotEmpty)
                  pw.Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
                if (paymentInfo['transactionId'] != null &&
                    paymentInfo['transactionId'].toString().isNotEmpty)
                  pw.Text("Transaction ID: ${paymentInfo['transactionId']}"),
                if (paymentInfo['cardName'] != null &&
                    paymentInfo['cardName'].toString().isNotEmpty)
                  pw.Text("Cardholder Name: ${paymentInfo['cardName']}"),
                if (paymentInfo['cardNumber'] != null &&
                    paymentInfo['cardNumber'].toString().isNotEmpty)
                  pw.Text("Card Number: ${paymentInfo['cardNumber']}"),
                pw.SizedBox(height: 20),

                // Items Table
                pw.Text(
                  "Ordered Items",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Table.fromTextArray(
                  headers: ["Product", "Qty", "Price"],
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.black),
                  cellAlignment: pw.Alignment.centerLeft,
                  cellHeight: 30,
                  data: cartItems.map((item) {
                    return [
                      item['name'],
                      item['quantity'].toString(),
                      "৳${item['price']}",
                    ];
                  }).toList(),
                ),
                pw.SizedBox(height: 20),

                // Totals
                pw.Divider(),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("Subtotal: ৳${subtotal.toStringAsFixed(2)}"),
                      pw.Text("VAT (15%): ৳${vat.toStringAsFixed(2)}"),
                      pw.Text(
                        "Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}",
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "TOTAL: ৳${totalAmount.toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Invoice"),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
          centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdf(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Order info card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Code: $orderCode",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text("Order Date: $formattedDate"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Delivery Info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "🚚 Delivery Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Name: ${deliveryInfo['customerName']}"),
                    Text("Address: ${deliveryInfo['address']}"),
                    Text("Phone: ${deliveryInfo['phone']}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment Info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "💳 Payment Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Method: ${paymentInfo['method']}"),
                    if (paymentInfo['mobileType'] != null &&
                        paymentInfo['mobileType'].toString().isNotEmpty)
                      Text("Mobile Wallet: ${paymentInfo['mobileType']}"),
                    if (paymentInfo['transactionId'] != null &&
                        paymentInfo['transactionId'].toString().isNotEmpty)
                      Text("Transaction ID: ${paymentInfo['transactionId']}"),
                    if (paymentInfo['cardName'] != null &&
                        paymentInfo['cardName'].toString().isNotEmpty)
                      Text("Cardholder Name: ${paymentInfo['cardName']}"),
                    if (paymentInfo['cardNumber'] != null &&
                        paymentInfo['cardNumber'].toString().isNotEmpty)
                      Text("Card Number: ${paymentInfo['cardNumber']}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Items
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "📦 Ordered Items",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.black87),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Product",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Qty",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Price",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        ...cartItems.map(
                          (item) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['name']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['quantity'].toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("৳${item['price']}"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Totals
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Subtotal: ৳${subtotal.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "VAT (15%): ৳${vat.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Delivery Fee: ৳${deliveryFee.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "TOTAL: ৳${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => _generatePdf(context),
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text(
                "Download PDF",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
