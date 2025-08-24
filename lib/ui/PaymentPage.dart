/*
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPayment = 'Mobile Banking';
  String _selectedWallet = 'bKash';

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController transactionIdController = TextEditingController();

  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        title: const Text("Payment Method"),
        backgroundColor: const Color(0xFFF57224),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   "Select Payment Method",
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              Text(
                '💳 Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Payment method options
              Column(
                children: [
                  buildRadioTile("Mobile Banking"),
                  buildRadioTile("Card"),
                  buildRadioTile("Cash on Delivery"),
                ],
              ),
              const SizedBox(height: 20),

              // Mobile Banking Section
              if (_selectedPayment == 'Mobile Banking') ...[
                const Text(
                  '📱 Select Mobile Wallet',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildWalletOption('bKash', 'images/bkash.png'),
                    buildWalletOption('Nagad', 'images/nagad.png'),
                    buildWalletOption('Rocket', 'images/rocket.png'),
                  ],
                ),
                const SizedBox(height: 20),
                buildTextField('📱 Mobile Number', mobileController),
                const SizedBox(height: 12),
                buildTextField('🧾 Transaction ID', transactionIdController),
              ],

              // Card Section
              // if (_selectedPayment == 'Card') ...[
              //   const Text(
              //      '💳 Enter Card Details',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //   ),
              //   const SizedBox(height: 10),
              //   buildTextField("Cardholder Name", cardNameController),
              //   const SizedBox(height: 12),
              //   buildTextField("Card Number", cardNumberController),
              //   const SizedBox(height: 12),
              //   Row(
              //     children: [
              //       Expanded(
              //         child: buildTextField("Expiry (MM/YY)", expiryController),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: buildTextField("CVV", cvvController),
              //       ),
              //     ],
              //   ),
              // ],

              // Card Section
              if (_selectedPayment == 'Card') ...[
                const Text(
                  '💳 Enter Card Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                buildTextField("👤 Cardholder Name", cardNameController),
                const SizedBox(height: 12),
                buildTextField("💳 Card Number", cardNumberController),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: buildTextField(
                        "📅 Expiry (MM/YY)",
                        expiryController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: buildTextField("🔒 CVV", cvvController)),
                  ],
                ),
              ],

              // COD Message
              if (_selectedPayment == 'Cash on Delivery') ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xfffef3c7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: const Text(
                    '💵 You will pay in cash upon delivery.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],

              const SizedBox(height: 30),

              // Confirm Order button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Order confirmation logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF57224),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Confirm Order",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Radio button builder
  Widget buildRadioTile(String value) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedPayment,
      onChanged: (val) {
        setState(() {
          _selectedPayment = val!;
        });
      },
      title: Text(value),
      activeColor: const Color(0xFFF57224),
    );
  }

  // Wallet option builder
  Widget buildWalletOption(String name, String imagePath) {
    final isSelected = _selectedWallet == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedWallet = name;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? const Color(0xffecfeff) : Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 40, height: 40),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // Common text field builder
  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFF57224), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
*/

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/ui/InvoicePage.dart';
// import 'package:http/http.dart' as http;

// class PaymentPage extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;
//   final Map<String, dynamic> deliveryInfo;

//   const PaymentPage({
//     super.key,
//     required this.cartItems,
//     required this.deliveryInfo,
//   });

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   String? selectedMethod;
//   String? mobileType;

//   TextEditingController mobileNumberController = TextEditingController();
//   TextEditingController transactionIdController = TextEditingController();
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController cardNumberController = TextEditingController();
//   TextEditingController expiryDateController = TextEditingController();
//   TextEditingController cvvController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   bool isLoading = false;

//   // Your backend endpoint URL here:
//   final String backendUrl = 'http://localhost:8080/orders'; // <-- Change to your API URL

//   Future<void> submitPayment() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (selectedMethod == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select a payment method")),
//       );
//       return;
//     }
//     if (selectedMethod == "mobile" && (mobileType == null || mobileType!.isEmpty)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select a mobile wallet")),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       // Calculate subtotal, vat, deliveryFee, total
//       double subtotal = 0;
//       for (var item in widget.cartItems) {
//         subtotal += (item['price'] as num) * (item['quantity'] as num);
//       }
//       double vat = subtotal * 0.05; // example 5% VAT
//       double deliveryFee = 50; // example fixed delivery fee
//       double total = subtotal + vat + deliveryFee;

//       // Build order items list
//       List<Map<String, dynamic>> orderItems = widget.cartItems.map((item) {
//         return {
//           "name": item['name'],
//           "quantity": item['quantity'],
//           "price": item['price'],
//           // optionally add orderDate if you want here
//         };
//       }).toList();

//       // Build the order payload matching your Angular model
//       Map<String, dynamic> orderPayload = {
//         "date": DateTime.now().toIso8601String(),
//         "customerName": widget.deliveryInfo['customerName'],
//         "phone": widget.deliveryInfo['phone'],
//         "address": widget.deliveryInfo['address'],
//         "paymentMethod": selectedMethod == "Cash on delivery" ? "cod" : (selectedMethod == "mobile" ? "mobile" : "card"),
//         "mobileType": selectedMethod == "mobile" ? mobileType : null,
//         "items": orderItems,
//         "subtotal": subtotal,
//         "vat": vat,
//         "deliveryFee": deliveryFee,
//         "total": total,
//       };

//       // Add payment details depending on method
//       if (selectedMethod == "mobile") {
//         orderPayload.addAll({
//           "mobileNumber": mobileNumberController.text,
//           "transactionId": transactionIdController.text,
//         });
//       } else if (selectedMethod == "card") {
//         orderPayload.addAll({
//           "cardName": fullNameController.text,
//           "cardNumber": cardNumberController.text,
//           "expiryDate": expiryDateController.text,
//           "cvv": cvvController.text,
//         });
//       }

//       // Send to backend
//       final response = await http.post(
//         Uri.parse(backendUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(orderPayload),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Success: parse backend response if needed
//         final responseData = jsonDecode(response.body);

//         // Here I assume backend returns the saved order data including id etc.
//         // You can adjust as per your backend response format
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("✅ Payment & Order submitted successfully")),
//         );

//         // Navigate to invoice page, passing backend data or local data
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InvoicePage(
//               cartItems: widget.cartItems,
//               deliveryInfo: widget.deliveryInfo,
//               paymentInfo: {
//                 "method": selectedMethod,
//                 "mobileType": mobileType,
//                 "transactionId": transactionIdController.text,
//                 "cardName": fullNameController.text,
//                 "cardNumber": cardNumberController.text,
//               },
//               // Optionally you can add responseData for more info if InvoicePage supports it
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to submit order: ${response.statusCode}")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error submitting order: $e")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Widget paymentOption(String value, String title, String imgPath) {
//     return GestureDetector(
//       onTap: () => setState(() {
//         selectedMethod = value;
//         if (value != "mobile") {
//           mobileType = null; // reset mobileType if not mobile method
//         }
//       }),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(color: selectedMethod == value ? Colors.teal : Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//           color: selectedMethod == value ? Colors.teal.withOpacity(0.1) : Colors.white,
//         ),
//         child: Row(
//           children: [
//             Image.asset(imgPath, width: 40),
//             const SizedBox(width: 10),
//             Text(title, style: const TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget walletOption(String value, String title, String imgPath) {
//     return GestureDetector(
//       onTap: () => setState(() => mobileType = value),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(color: mobileType == value ? Colors.teal : Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//           color: mobileType == value ? Colors.teal.withOpacity(0.1) : Colors.white,
//         ),
//         child: Column(
//           children: [
//             Image.asset(imgPath, width: 50),
//             const SizedBox(height: 4),
//             Text(title),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Payment Method"),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     const Text("Choose Payment Method",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 16),

//                     // Payment Method Selection
//                     paymentOption("mobile", "Mobile Banking", "images/mobile-banking.png"),
//                     const SizedBox(height: 10),
//                     paymentOption("card", "Card", "images/card-icon.png"),
//                     const SizedBox(height: 10),
//                     paymentOption("Cash on delivery", "Cash On Delivery", "images/cash-delivery.png"),

//                     const SizedBox(height: 20),

//                     // Mobile Banking Section
//                     if (selectedMethod == "mobile") ...[
//                       const Text("Select Mobile Wallet",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           walletOption("bKash", "bKash", "images/bkash.png"),
//                           walletOption("Nagad", "Nagad", "images/nagad.png"),
//                           walletOption("Rocket", "Rocket", "images/rocket.png"),
//                         ],
//                       ),

//                       if (mobileType != null && mobileType!.isNotEmpty) ...[
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: mobileNumberController,
//                           decoration: const InputDecoration(
//                             labelText: "Mobile Number",
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (val) => val!.isEmpty ? "Enter Mobile Number" : null,
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: transactionIdController,
//                           decoration: const InputDecoration(
//                             labelText: "Transaction ID",
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (val) => val!.isEmpty ? "Enter Transaction ID" : null,
//                         ),
//                       ],
//                     ],

//                     // Card Payment Section
//                     if (selectedMethod == "card") ...[
//                       TextFormField(
//                         controller: fullNameController,
//                         decoration: const InputDecoration(
//                           labelText: "Full Name on Card",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (val) => val!.isEmpty ? "Enter Full Name" : null,
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         controller: cardNumberController,
//                         maxLength: 16,
//                         decoration: const InputDecoration(
//                           labelText: "Card Number",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (val) => val!.isEmpty ? "Enter Card Number" : null,
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         controller: expiryDateController,
//                         decoration: const InputDecoration(
//                           labelText: "Expiry Date (MM/YY)",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (val) => val!.isEmpty ? "Enter Expiry Date" : null,
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         controller: cvvController,
//                         maxLength: 3,
//                         decoration: const InputDecoration(
//                           labelText: "CVV",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (val) => val!.isEmpty ? "Enter CVV" : null,
//                       ),
//                     ],

//                     // COD Section
//                     if (selectedMethod == "Cash on delivery")
//                       const Padding(
//                         padding: EdgeInsets.all(12),
//                         child: Text(
//                           "💵 You will pay in cash upon delivery.",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),

//                     const SizedBox(height: 20),

//                     ElevatedButton.icon(
//                       onPressed: submitPayment,
//                       icon: const Icon(Icons.payment, color: Colors.white),
//                       label: const Text(
//                         "Pay Now",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         textStyle: const TextStyle(fontSize: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

//updated with date

/* import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ecommerce/ui/InvoicePage.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;

  const PaymentPage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
    required double subtotal,
    required double vat,
    required double deliveryFee,
    required double total,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String generateOrderCode() {
    const length = 6;
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();

    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  // String generateOrderCode() {
  // final now = DateTime.now();
  // final random = Random();
  // final code =
  //     "ORD-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}"
  //     "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}"
  //     "${random.nextInt(9999).toString().padLeft(4, '0')}";
  //       return code;
  //     }
  String? selectedMethod;
  String? mobileType;

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final String backendUrl = 'http://localhost:8080/orders';

  Future<void> submitPayment() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a payment method")),
      );
      return;
    }
    if (selectedMethod == "mobile" &&
        (mobileType == null || mobileType!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a mobile wallet")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Calculate subtotal, vat, deliveryFee, total
      double subtotal = 0;
      for (var item in widget.cartItems) {
        subtotal += (item['price'] as num) * (item['quantity'] as num);
      }
      double vat = subtotal * 0.15; // 15% VAT উদাহরণ
      double deliveryFee = 60; // ফিক্সড delivery fee
      double total = subtotal + vat + deliveryFee;

      // Build order items list
      List<Map<String, dynamic>> orderItems = widget.cartItems.map((item) {
        return {
          "name": item['name'],
          "quantity": item['quantity'],
          "price": item['price'],
        };
      }).toList();

      final orderCode = generateOrderCode();

      Map<String, dynamic> orderPayload = {
        "orderCode": orderCode,
        "date": DateTime.now().toIso8601String(),
        "customerName": widget.deliveryInfo['customerName'],
        "phone": widget.deliveryInfo['phone'],
        "address": widget.deliveryInfo['address'],
        "paymentMethod": selectedMethod == "Cash on delivery"
            ? "cod"
            : (selectedMethod == "mobile" ? "mobile" : "card"),
        "mobileType": selectedMethod == "mobile" ? mobileType : null,
        "items": orderItems,
        "subtotal": subtotal,
        "vat": vat,
        "deliveryFee": deliveryFee,
        "total": total,
      };

      if (selectedMethod == "mobile") {
        orderPayload.addAll({
          "mobileNumber": mobileNumberController.text,
          "transactionId": transactionIdController.text,
        });
      } else if (selectedMethod == "card") {
        orderPayload.addAll({
          "cardName": fullNameController.text,
          "cardNumber": cardNumberController.text,
          "expiryDate": expiryDateController.text,
          "cvv": cvvController.text,
        });
      }

      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderPayload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Payment & Order submitted successfully"),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => InvoicePage(
              cartItems: widget.cartItems,
              deliveryInfo: widget.deliveryInfo,
              paymentInfo: {
                "method": selectedMethod,
                "mobileType": mobileType,
                "transactionId": transactionIdController.text,
                "cardName": fullNameController.text,
                "cardNumber": cardNumberController.text,
              },
              deliveryFee: deliveryFee,
              subtotal: subtotal,
              vat: vat,
              orderDate: DateTime.now(),
              orderCode: orderCode,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to submit order: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error submitting order: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget paymentOption(String value, String title, String imgPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = value;
          if (value != "mobile") mobileType = null;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedMethod == value ? Colors.teal : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selectedMethod == value
              ? Colors.teal.withOpacity(0.1)
              : Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(imgPath, width: 40),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget walletOption(String value, String title, String imgPath) {
    return GestureDetector(
      onTap: () => setState(() => mobileType = value),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: mobileType == value ? Colors.teal : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
          color: mobileType == value
              ? Colors.teal.withOpacity(0.1)
              : Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(imgPath, width: 50),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Payment Method"),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 255, 93, 18),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      "Choose Payment Method",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    paymentOption(
                      "mobile",
                      "Mobile Banking",
                      "images/mobile-banking.png",
                    ),
                    const SizedBox(height: 10),
                    paymentOption("card", "Card", "images/card-icon.png"),
                    const SizedBox(height: 10),
                    paymentOption(
                      "Cash on delivery",
                      "Cash On Delivery",
                      "images/cash-delivery.png",
                    ),

                    const SizedBox(height: 20),

                    if (selectedMethod == "mobile") ...[
                      const Text(
                        "Select Mobile Wallet",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          walletOption("bKash", "bKash", "images/bkash.png"),
                          walletOption("Nagad", "Nagad", "images/nagad.png"),
                          walletOption("Rocket", "Rocket", "images/rocket.png"),
                        ],
                      ),
                      if (mobileType != null && mobileType!.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: mobileNumberController,
                          decoration: const InputDecoration(
                            labelText: "Mobile Number",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? "Enter Mobile Number" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: transactionIdController,
                          decoration: const InputDecoration(
                            labelText: "Transaction ID",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? "Enter Transaction ID" : null,
                        ),
                      ],
                    ],

                    if (selectedMethod == "card") ...[
                      TextFormField(
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: "Full Name on Card",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) =>
                            val!.isEmpty ? "Enter Full Name" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cardNumberController,
                        maxLength: 16,
                        decoration: const InputDecoration(
                          labelText: "Card Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) =>
                            val!.isEmpty ? "Enter Card Number" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: expiryDateController,
                        decoration: const InputDecoration(
                          labelText: "Expiry Date (MM/YY)",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) =>
                            val!.isEmpty ? "Enter Expiry Date" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cvvController,
                        maxLength: 3,
                        decoration: const InputDecoration(
                          labelText: "CVV",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val!.isEmpty ? "Enter CVV" : null,
                      ),
                    ],

                    if (selectedMethod == "Cash on delivery")
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "💵 You will pay in cash upon delivery.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: submitPayment,
                      icon: const Icon(Icons.payment, color: Colors.white),
                      label: const Text(
                        "Pay Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 93, 18),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
 */



import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ecommerce/ui/InvoicePage.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;

  const PaymentPage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
    required double subtotal,
    required double vat,
    required double deliveryFee,
    required double total,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String generateOrderCode() {
    const length = 6;
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();

    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  String? selectedMethod;
  String? mobileType;

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final String backendUrl = 'http://localhost:8080/orders';

  Future<void> submitPayment() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a payment method")),
      );
      return;
    }
    if (selectedMethod == "mobile" &&
        (mobileType == null || mobileType!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a mobile wallet")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      double subtotal = 0;
      for (var item in widget.cartItems) {
        subtotal += (item['price'] as num) * (item['quantity'] as num);
      }
      double vat = subtotal * 0.15;
      double deliveryFee = 60;
      double total = subtotal + vat + deliveryFee;

      List<Map<String, dynamic>> orderItems = widget.cartItems.map((item) {
        return {
          "name": item['name'],
          "quantity": item['quantity'],
          "price": item['price'],
        };
      }).toList();

      final orderCode = generateOrderCode();

      Map<String, dynamic> orderPayload = {
        "orderCode": orderCode,
        "date": DateTime.now().toIso8601String(),
        "customerName": widget.deliveryInfo['customerName'],
        "phone": widget.deliveryInfo['phone'],
        "address": widget.deliveryInfo['address'],
        "paymentMethod": selectedMethod == "Cash on delivery"
            ? "cod"
            : (selectedMethod == "mobile" ? "mobile" : "card"),
        "mobileType": selectedMethod == "mobile" ? mobileType : null,
        "items": orderItems,
        "subtotal": subtotal,
        "vat": vat,
        "deliveryFee": deliveryFee,
        "total": total,
      };

      if (selectedMethod == "mobile") {
        orderPayload.addAll({
          "mobileNumber": mobileNumberController.text,
          "transactionId": transactionIdController.text,
        });
      } else if (selectedMethod == "card") {
        orderPayload.addAll({
          "cardName": fullNameController.text,
          "cardNumber": cardNumberController.text,
          "expiryDate": expiryDateController.text,
          "cvv": cvvController.text,
        });
      }

      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderPayload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Payment & Order submitted successfully"),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => InvoicePage(
              cartItems: widget.cartItems,
              deliveryInfo: widget.deliveryInfo,
              paymentInfo: {
                "method": selectedMethod,
                "mobileType": mobileType,
                "transactionId": transactionIdController.text,
                "cardName": fullNameController.text,
                "cardNumber": cardNumberController.text,
              },
              deliveryFee: deliveryFee,
              subtotal: subtotal,
              vat: vat,
              orderDate: DateTime.now(),
              orderCode: orderCode,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to submit order: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error submitting order: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget paymentOption(String value, String title, String imgPath) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = value;
            if (value != "mobile") mobileType = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedMethod == value ? Colors.teal : Colors.grey.shade300,
              width: selectedMethod == value ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: selectedMethod == value ? Colors.teal.withOpacity(0.1) : Colors.white,
            boxShadow: [
              if (selectedMethod == value)
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(imgPath, width: 50),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget walletOption(String value, String title, String imgPath) {
    return GestureDetector(
      onTap: () => setState(() => mobileType = value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: mobileType == value ? Colors.teal : Colors.grey.shade300,
            width: mobileType == value ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: mobileType == value ? Colors.teal.withOpacity(0.1) : Colors.white,
          boxShadow: [
            if (mobileType == value)
              BoxShadow(
                color: Colors.teal.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imgPath, width: 50),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Payment Method"),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 255, 93, 18),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Choose Payment Method",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment options row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        paymentOption("mobile", "Mobile Banking", "images/mobile-banking.png"),
                        const SizedBox(width: 10),
                        paymentOption("card", "Card", "images/card-icon.png"),
                        const SizedBox(width: 10),
                        paymentOption("Cash on delivery", "Cash On Delivery", "images/cash-delivery.png"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Mobile Wallet selection
                    if (selectedMethod == "mobile") ...[
                      const Text(
                        "Select Mobile Wallet",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          walletOption("bKash", "bKash", "images/bkash.png"),
                          walletOption("Nagad", "Nagad", "images/nagad.png"),
                          walletOption("Rocket", "Rocket", "images/rocket.png"),
                        ],
                      ),
                      if (mobileType != null && mobileType!.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: mobileNumberController,
                          decoration: const InputDecoration(
                            labelText: "Mobile Number",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val!.isEmpty ? "Enter Mobile Number" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: transactionIdController,
                          decoration: const InputDecoration(
                            labelText: "Transaction ID",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val!.isEmpty ? "Enter Transaction ID" : null,
                        ),
                      ],
                    ],

                    // Card fields
                    if (selectedMethod == "card") ...[
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: "Full Name on Card",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val!.isEmpty ? "Enter Full Name" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cardNumberController,
                        maxLength: 16,
                        decoration: const InputDecoration(
                          labelText: "Card Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val!.isEmpty ? "Enter Card Number" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: expiryDateController,
                        decoration: const InputDecoration(
                          labelText: "Expiry Date (MM/YY)",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val!.isEmpty ? "Enter Expiry Date" : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cvvController,
                        maxLength: 3,
                        decoration: const InputDecoration(
                          labelText: "CVV",
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val!.isEmpty ? "Enter CVV" : null,
                      ),
                    ],

                    if (selectedMethod == "Cash on delivery")
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "💵 You will pay in cash upon delivery.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: submitPayment,
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text(
                          "Pay Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 93, 18),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
