/*
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotal() {
    return widget.cartItems.fold(0.0, (sum, item) => sum + item['price']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🛒 My Cart"),
        backgroundColor: Colors.deepOrange,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text("Cart is empty!", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Image.network(
                      item['imageUrl'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("৳${item['price']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total: ৳${calculateTotal().toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                // Checkout action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
*/

// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/ui/CheckoutPage.dart';

// class CartPage extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;

//   const CartPage({Key? key, required this.cartItems}) : super(key: key);

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   // quantity রাখার জন্য
//   Map<int, int> quantities = {};

//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.cartItems.length; i++) {
//       quantities[i] = 1;
//     }
//   }

//   double getTotalPrice() {
//     double total = 0;
//     for (int i = 0; i < widget.cartItems.length; i++) {
//       total += widget.cartItems[i]['price'] * (quantities[i] ?? 1);
//     }
//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🛒 My Cart"),
//         // centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: widget.cartItems.isEmpty
//           ? Center(child: Text('Your cart is empty'))
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: widget.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final item = widget.cartItems[index];
//                       return Card(
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 5,
//                         ),
//                         elevation: 4,
//                         child: ListTile(
//                           leading: Image.network(
//                             item['imageUrl'],
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                           title: Text(item['name']),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('৳${item['price']}'),
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(Icons.remove),
//                                     onPressed: () {
//                                       setState(() {
//                                         if (quantities[index]! > 1) {
//                                           quantities[index] =
//                                               quantities[index]! - 1;
//                                         }
//                                       });
//                                     },
//                                   ),
//                                   Text('${quantities[index]}'),
//                                   IconButton(
//                                     icon: Icon(Icons.add),
//                                     onPressed: () {
//                                       setState(() {
//                                         quantities[index] =
//                                             quantities[index]! + 1;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               setState(() {
//                                 widget.cartItems.removeAt(index);
//                                 quantities.remove(index);
//                               });
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total:',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '৳${getTotalPrice().toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Checkout functionality এখানে করবে
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => CheckoutPage()),
//                           );
//                         },
//                         child: Text('Checkout'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           foregroundColor: Colors.white,
//                           minimumSize: Size(double.infinity, 50),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/ui/CheckoutPage.dart'; // তোমার CheckoutPage এখানে import করতে হবে

// class CartPage extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;

//   const CartPage({Key? key, required this.cartItems}) : super(key: key);

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   Map<int, int> quantities = {};

//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.cartItems.length; i++) {
//       quantities[i] = 1;
//     }
//   }

//   double getTotalPrice() {
//     double total = 0;
//     for (int i = 0; i < widget.cartItems.length; i++) {
//       total += widget.cartItems[i]['price'] * (quantities[i] ?? 1);
//     }
//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWeb = screenWidth > 700;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: widget.cartItems.isEmpty
//           ? Center(child: Text('Your cart is empty'))
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: widget.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final item = widget.cartItems[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         child: Card(
//                           elevation: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: isWeb
//                                 ? Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Image.network(
//                                         item['imageUrl'],
//                                         width: 100,
//                                         height: 100,
//                                         fit: BoxFit.cover,
//                                       ),
//                                       SizedBox(width: 20),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(item['name'],
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.bold)),
//                                             SizedBox(height: 5),
//                                             Text('৳${item['price']}'),
//                                             Row(
//                                               children: [
//                                                 IconButton(
//                                                   icon: Icon(Icons.remove),
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       if (quantities[index]! >
//                                                           1) {
//                                                         quantities[index] =
//                                                             quantities[
//                                                                     index]! -
//                                                                 1;
//                                                       }
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text('${quantities[index]}'),
//                                                 IconButton(
//                                                   icon: Icon(Icons.add),
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       quantities[index] =
//                                                           quantities[index]! +
//                                                               1;
//                                                     });
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       IconButton(
//                                         icon: Icon(Icons.delete,
//                                             color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             widget.cartItems.removeAt(index);
//                                             quantities.remove(index);
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   )
//                                 : ListTile(
//                                     leading: Image.network(
//                                       item['imageUrl'],
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     title: Text(item['name']),
//                                     subtitle: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text('৳${item['price']}'),
//                                         Row(
//                                           children: [
//                                             IconButton(
//                                               icon: Icon(Icons.remove),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   if (quantities[index]! > 1) {
//                                                     quantities[index] =
//                                                         quantities[index]! - 1;
//                                                   }
//                                                 });
//                                               },
//                                             ),
//                                             Text('${quantities[index]}'),
//                                             IconButton(
//                                               icon: Icon(Icons.add),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   quantities[index] =
//                                                       quantities[index]! + 1;
//                                                 });
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     trailing: IconButton(
//                                       icon:
//                                           Icon(Icons.delete, color: Colors.red),
//                                       onPressed: () {
//                                         setState(() {
//                                           widget.cartItems.removeAt(index);
//                                           quantities.remove(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total:',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '৳${getTotalPrice().toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => CheckoutPage()), // checkout
//                           );
//                         },
//                         child: Text('Checkout'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           foregroundColor: Colors.white,
//                           minimumSize: Size(double.infinity, 50),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/CheckoutPage.dart';

/* class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.cartItems.length; i++) {
      quantities[i] = 1;
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      total += widget.cartItems[i]['price'] * (quantities[i] ?? 1);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('🛒 My Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                '🛍️ Your cart is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item['mainImage'],
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          title: Text(
                            item['productName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '৳${item['price']}',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    _quantityButton(
                                      icon: Icons.remove,
                                      onPressed: () {
                                        setState(() {
                                          if (quantities[index]! > 1) {
                                            quantities[index] =
                                                quantities[index]! - 1;
                                          }
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Text(
                                        '${quantities[index]}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    _quantityButton(
                                      icon: Icons.add,
                                      onPressed: () {
                                        setState(() {
                                          quantities[index] =
                                              quantities[index]! + 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.cartItems.removeAt(index);
                                quantities.remove(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildBottomCheckoutCard(),
              ],
            ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: Colors.deepPurple),
      ),
    );
  }

  Widget _buildBottomCheckoutCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '৳${getTotalPrice().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                    cartItems: widget.cartItems.map((item) {
                      int index = widget.cartItems.indexOf(item);
                      return {
                        'name': item['ProductName'],
                        'price': item['price'],
                        'imageUrl': item['mainImage'],
                        'quantity': quantities[index] ?? 1,
                      };
                    }).toList(),
                    product: {},
                  ),
                ),
              );
            },
            icon: const Icon(Icons.payment),
            label: const Text(
              'Proceed to Checkout',
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 37, 156, 97),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<int, int> quantities = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.cartItems.length; i++) {
      quantities[i] = 1;
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      total += (widget.cartItems[i]['price'] ?? 0) * (quantities[i] ?? 1);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('🛒 My Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                '🛍️ Your cart is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item['imageUrl'] ?? '',
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          title: Text(
                            item['name'] ?? 'Unknown',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '৳${item['price'] ?? 0}',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    _quantityButton(
                                      icon: Icons.remove,
                                      onPressed: () {
                                        setState(() {
                                          if (quantities[index]! > 1) {
                                            quantities[index] =
                                                quantities[index]! - 1;
                                          }
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Text(
                                        '${quantities[index]}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    _quantityButton(
                                      icon: Icons.add,
                                      onPressed: () {
                                        setState(() {
                                          quantities[index] =
                                              quantities[index]! + 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.cartItems.removeAt(index);
                                quantities.remove(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildBottomCheckoutCard(),
              ],
            ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: Colors.deepPurple),
      ),
    );
  }

  Widget _buildBottomCheckoutCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '৳${getTotalPrice().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                    cartItems: widget.cartItems.map((item) {
                      int index = widget.cartItems.indexOf(item);
                      return {
                        'name': item['name'] ?? 'Unknown',
                        'price': item['price'] ?? 0,
                        'imageUrl': item['imageUrl'] ?? '',
                        'quantity': quantities[index] ?? 1,
                      };
                    }).toList(),
                    product: {},
                  ),
                ),
              );
            },
            icon: const Icon(Icons.payment),
            label: const Text(
              'Proceed to Checkout',
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 93, 18),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
