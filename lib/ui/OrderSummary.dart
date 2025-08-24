/* import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/PaymentPage.dart';

class OrderSummaryDialog extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;

  const OrderSummaryDialog({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
  });

  double getItemsTotal() {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  double getDeliveryFee() => 60;
  double getVAT() => getItemsTotal() * 0.15;
  double getSubtotal() => getItemsTotal() + getVAT();
  double getGrandTotal() => getSubtotal() + getDeliveryFee();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildPriceRow(
              "Items Price (${cartItems.length} items)",
              getItemsTotal(),
            ),
            _buildPriceRow("VAT (15%)", getVAT()),
            _buildPriceRow("Subtotal", getItemsTotal() + getVAT()),
            _buildPriceRow("Delivery Fee", getDeliveryFee()),
            const Divider(height: 20),
            _buildPriceRow("Grand Total", getGrandTotal(), isTotal: true),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        cartItems: cartItems,
                        deliveryInfo: deliveryInfo,
                        subtotal: getItemsTotal(),
                        vat: getVAT(),
                        deliveryFee: getDeliveryFee(),
                        total: getGrandTotal(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("PROCEED TO PAYMENT"),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text("Secure Checkout", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "৳${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}


 */

/* import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/PaymentPage.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;

  const OrderSummaryPage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
  });

  double getItemsTotal() {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  double getVAT() => getItemsTotal() * 0.15;
  double getDeliveryFee() => 60.0;
  double getGrandTotal() => getItemsTotal() + getVAT() + getDeliveryFee();

  // @override
  // Widget build(BuildContext context) {
  //   final isMobile = MediaQuery.of(context).size.width < 600;

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Order Summary"),
  //       centerTitle: true,
  //       backgroundColor: const Color.fromARGB(255, 255, 93, 18),
  //       foregroundColor: Colors.white,
  //       elevation: 2,
  //     ),
  //     backgroundColor: const Color(0xFFF5F5F5),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           // Ordered Products Card
  //           Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             elevation: 4,
  //             color: Colors.white,
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Ordered Products",
  //                     style: TextStyle(
  //                       fontSize: 22,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.teal,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   // Responsive list for products
  //                   ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: cartItems.length,
  //                     itemBuilder: (context, index) {
  //                       final item = cartItems[index];
  //                       return Container(
  //                         margin: const EdgeInsets.symmetric(vertical: 6),
  //                         padding: const EdgeInsets.all(12),
  //                         decoration: BoxDecoration(
  //                           color: index % 2 == 0
  //                               ? Colors.grey.shade100
  //                               : Colors.white,
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             // Product Name
  //                             Expanded(
  //                               flex: 4,
  //                               child: Text(
  //                                 item['name'],
  //                                 style: const TextStyle(fontSize: 16),
  //                               ),
  //                             ),
  //                             // Quantity
  //                             Expanded(
  //                               flex: 2,
  //                               child: Text(
  //                                 "Qty: ${item['quantity']}",
  //                                 style: const TextStyle(fontSize: 16),
  //                               ),
  //                             ),
  //                             // Price
  //                             Expanded(
  //                               flex: 2,
  //                               child: Text(
  //                                 "৳${item['price']}",
  //                                 style: const TextStyle(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 20),
  //           // Totals Card
  //           Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             elevation: 4,
  //             color: Colors.white,
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: Column(
  //                 children: [
  //                   _buildTotalRow("Items Total", getItemsTotal()),
  //                   _buildTotalRow("VAT (15%)", getVAT()),
  //                   _buildTotalRow("Delivery Fee", getDeliveryFee()),
  //                   const Divider(height: 24, thickness: 1, color: Colors.grey),
  //                   _buildTotalRow(
  //                     "Grand Total",
  //                     getGrandTotal(),
  //                     isGrand: true,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 20),
  //           // Proceed Button
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => PaymentPage(
  //                       cartItems: cartItems,
  //                       deliveryInfo: deliveryInfo,
  //                       subtotal: getItemsTotal(),
  //                       vat: getVAT(),
  //                       deliveryFee: getDeliveryFee(),
  //                       total: getGrandTotal(),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 padding: const EdgeInsets.symmetric(vertical: 16),
  //                 backgroundColor: const Color.fromARGB(255, 255, 93, 18),
  //                 foregroundColor: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 textStyle: const TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               child: const Text("Proceed to Payment"),
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: const [
  //               Icon(Icons.lock, size: 18, color: Colors.grey),
  //               SizedBox(width: 6),
  //               Text("Secure Checkout", style: TextStyle(color: Colors.grey)),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ... আগের imports এবং class declaration একই ...

@override
Widget build(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  return Scaffold(
    appBar: AppBar(
      title: const Text("Order Summary"),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 255, 93, 18),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    backgroundColor: const Color(0xFFF5F5F5),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Ordered Products Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ordered Products",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Table Heading
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Quantity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Responsive list for products
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.grey.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                item['name'],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Qty: ${item['quantity']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "৳${item['price']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Totals Card (previous code same)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTotalRow("Items Total", getItemsTotal()),
                  _buildTotalRow("VAT (15%)", getVAT()),
                  _buildTotalRow("Delivery Fee", getDeliveryFee()),
                  const Divider(height: 24, thickness: 1, color: Colors.grey),
                  _buildTotalRow(
                    "Grand Total",
                    getGrandTotal(),
                    isGrand: true,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Proceed Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      cartItems: cartItems,
                      deliveryInfo: deliveryInfo,
                      subtotal: getItemsTotal(),
                      vat: getVAT(),
                      deliveryFee: getDeliveryFee(),
                      total: getGrandTotal(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color.fromARGB(255, 255, 93, 18),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Proceed to Payment"),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock, size: 18, color: Colors.grey),
              SizedBox(width: 6),
              Text("Secure Checkout", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    ),
  );
}


  Widget _buildTotalRow(String label, double value, {bool isGrand = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isGrand ? 18 : 16,
              fontWeight: isGrand ? FontWeight.bold : FontWeight.normal,
              color: isGrand ? Colors.teal : Colors.black87,
            ),
          ),
          Text(
            "৳${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isGrand ? 18 : 16,
              fontWeight: isGrand ? FontWeight.bold : FontWeight.normal,
              color: isGrand ? Colors.teal : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
 */


import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/PaymentPage.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic> deliveryInfo;

  const OrderSummaryPage({
    super.key,
    required this.cartItems,
    required this.deliveryInfo,
  });

  double getItemsTotal() {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  double getVAT() => getItemsTotal() * 0.15;
  double getDeliveryFee() => 60.0;
  double getGrandTotal() => getItemsTotal() + getVAT() + getDeliveryFee();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 93, 18),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ordered Products Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Products",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Products Table
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(2),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.deepOrangeAccent),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Product",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Qty",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Price",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...cartItems.map(
                          (item) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item['name'],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item['quantity'].toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "৳${item['price']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
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

            const SizedBox(height: 20),

            // Totals Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTotalRow("Items Total", getItemsTotal()),
                    _buildTotalRow("VAT (15%)", getVAT()),
                    _buildTotalRow("Delivery Fee", getDeliveryFee()),
                    const Divider(height: 24, thickness: 1, color: Colors.grey),
                    _buildTotalRow(
                      "Grand Total",
                      getGrandTotal(),
                      isGrand: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        cartItems: cartItems,
                        deliveryInfo: deliveryInfo,
                        subtotal: getItemsTotal(),
                        vat: getVAT(),
                        deliveryFee: getDeliveryFee(),
                        total: getGrandTotal(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 255, 93, 18),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Proceed to Payment"),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text("Secure Checkout", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double value, {bool isGrand = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isGrand ? 18 : 16,
              fontWeight: isGrand ? FontWeight.bold : FontWeight.normal,
              color: isGrand ? Colors.teal : Colors.black87,
            ),
          ),
          Text(
            "৳${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isGrand ? 18 : 16,
              fontWeight: isGrand ? FontWeight.bold : FontWeight.normal,
              color: isGrand ? Colors.teal : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
