// import 'package:flutter/material.dart';
// import 'package:pharma_app/dashboard/Dashboard.dart';
// import 'package:pharma_app/ui/MedicinePage.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   bool isSidebarVisible = false;
//   String selectedMenu = 'Dashboard';

//   final menuItems = {
//     'Dashboard': Icons.dashboard,
//     'Manufacture': Icons.precision_manufacturing,
//     'Category': Icons.category,
//     'Sub Category': Icons.subdirectory_arrow_right,
//     'Medicines': Icons.medical_services,
//     'Order Management': Icons.assignment,
//     'Inventory': Icons.inventory,
//     'Sales Report': Icons.bar_chart,
//   };

//   final manufactureSubItems = {
//     'Raw Materials': Icons.bubble_chart,
//     'Raw Material Supplier': Icons.group,
//     'Raw Material Import': Icons.import_export,
//     'Manufacturing': Icons.build_circle,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ✅ Top Navbar
//             Container(
//               color: Colors.blue,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Pharma',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const SizedBox(width: 16),
//                       const Text('Admin', style: TextStyle(color: Colors.white)),
//                       const SizedBox(width: 16),
//                       IconButton(
//                         icon: const Icon(Icons.menu, color: Colors.white),
//                         onPressed: () {
//                           setState(() => isSidebarVisible = !isSidebarVisible);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // ✅ Body section - fully scrollable
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (isSidebarVisible)
//                         Container(
//                           color: Colors.white,
//                           width: double.infinity,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ...menuItems.entries.map((entry) {
//                                 if (entry.key == 'Manufacture') {
//                                   return ExpansionTile(
//                                     title: Text(entry.key),
//                                     leading: Icon(entry.value),
//                                     children: manufactureSubItems.entries.map((sub) {
//                                       return ListTile(
//                                         leading: Icon(sub.value, size: 20),
//                                         title: Text(sub.key),
//                                         onTap: () {
//                                           setState(() {
//                                             selectedMenu = sub.key;
//                                             isSidebarVisible = false;
//                                           });
//                                         },
//                                       );
//                                     }).toList(),
//                                   );
//                                 } else {
//                                   return ListTile(
//                                     leading: Icon(entry.value),
//                                     title: Text(entry.key),
//                                     onTap: () {
//                                       setState(() {
//                                         selectedMenu = entry.key;
//                                         isSidebarVisible = false;
//                                       });

//                                       if (entry.key == 'Medicines') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => MedicinePage(),
//                                           ),
//                                         );
//                                       }

//                                       if (entry.key == 'Dashboard') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => DashboardPage(),
//                                           ),
//                                         );
//                                       }

//                                     },
//                                   );
//                                 }
//                               }),
//                             ],
//                           ),
//                         ),

//                       // ✅ Main content
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Text(
//                           '$selectedMenu Page Content',
//                           style: const TextStyle(fontSize: 24),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//with logout

// import 'package:flutter/material.dart';
// import 'package:pharma_app/auth/login_page.dart';
// import 'package:pharma_app/dashboard/Dashboard.dart';
// import 'package:pharma_app/ui/MedicinePage.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   bool isSidebarVisible = false;
//   String selectedMenu = 'Dashboard';

//   final menuItems = {
//     'Dashboard': Icons.dashboard,
//     'Manufacture': Icons.precision_manufacturing,
//     'Category': Icons.category,
//     'Sub Category': Icons.subdirectory_arrow_right,
//     'Medicines': Icons.medical_services,
//     'Order Management': Icons.assignment,
//     'Inventory': Icons.inventory,
//     'Sales Report': Icons.bar_chart,
//   };

//   final manufactureSubItems = {
//     'Raw Materials': Icons.bubble_chart,
//     'Raw Material Supplier': Icons.group,
//     'Raw Material Import': Icons.import_export,
//     'Manufacturing': Icons.build_circle,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ✅ Top Navbar
//             Container(
//               color: Colors.blue,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Pharma',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const SizedBox(width: 16),
//                       const Text(
//                         'Admin',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(width: 16),
//                       IconButton(
//                         icon: const Icon(Icons.menu, color: Colors.white),
//                         onPressed: () {
//                           setState(() => isSidebarVisible = !isSidebarVisible);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // ✅ Body section - fully scrollable
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (isSidebarVisible)
//                         Container(
//                           color: Colors.white,
//                           width: double.infinity,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ...menuItems.entries.map((entry) {
//                                 if (entry.key == 'Manufacture') {
//                                   return ExpansionTile(
//                                     title: Text(entry.key),
//                                     leading: Icon(entry.value),
//                                     children: manufactureSubItems.entries.map((
//                                       sub,
//                                     ) {
//                                       return ListTile(
//                                         leading: Icon(sub.value, size: 20),
//                                         title: Text(sub.key),
//                                         onTap: () {
//                                           setState(() {
//                                             selectedMenu = sub.key;
//                                             isSidebarVisible = false;
//                                           });
//                                         },
//                                       );
//                                     }).toList(),
//                                   );
//                                 } else {
//                                   return ListTile(
//                                     leading: Icon(entry.value),
//                                     title: Text(entry.key),
//                                     onTap: () {
//                                       setState(() {
//                                         selectedMenu = entry.key;
//                                         isSidebarVisible = false;
//                                       });

//                                       if (entry.key == 'Medicines') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 MedicinePage(),
//                                           ),
//                                         );
//                                       }

//                                       if (entry.key == 'Dashboard') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 DashboardPage(),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   );
//                                 }
//                               }).toList(),

//                               const Divider(),

//                               // Logout option
//                               ListTile(
//                                 leading: const Icon(
//                                   Icons.logout,
//                                   color: Colors.red,
//                                 ),
//                                 title: const Text(
//                                   'Logout',
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                                 onTap: () {
//                                   // Close sidebar
//                                   setState(() {
//                                     isSidebarVisible = false;
//                                   });

//                                   Navigator.of(
//                                     context,
//                                   ).popUntil((route) => route.isFirst);
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => LoginPage(),
//                                     ),
//                                   );

//                                 },
//                               ),
//                             ],
//                           ),
//                         ),

//                       // ✅ Main content

//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Text(
//                           '$selectedMenu Page Content',
//                           style: const TextStyle(fontSize: 24),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//defaualt dashboard

// import 'package:flutter/material.dart';
// import 'package:pharma_app/auth/login_page.dart';
// import 'package:pharma_app/dashboard/Dashboard.dart';
// import 'package:pharma_app/ui/MedicinePage.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   bool isSidebarVisible = true; // true করলে সাইডবার ডিফল্ট দেখা যাবে
//   String selectedMenu = 'Dashboard';

//   final menuItems = {
//     'Dashboard': Icons.dashboard,
//     'Manufacture': Icons.precision_manufacturing,
//     'Category': Icons.category,
//     'Sub Category': Icons.subdirectory_arrow_right,
//     'Medicines': Icons.medical_services,
//     'Order Management': Icons.assignment,
//     'Inventory': Icons.inventory,
//     'Sales Report': Icons.bar_chart,
//   };

//   final manufactureSubItems = {
//     'Raw Materials': Icons.bubble_chart,
//     'Raw Material Supplier': Icons.group,
//     'Raw Material Import': Icons.import_export,
//     'Manufacturing': Icons.build_circle,
//   };

//   Widget _getPageByMenu(String menu) {
//     switch (menu) {
//       case 'Dashboard':
//         return const DashboardPage();
//       case 'Medicines':
//         return const MedicinePage();
//       default:
//         return Center(
//           child: Text(
//             '$menu Page Content',
//             style: const TextStyle(fontSize: 24),
//           ),
//         );
//     }
//   }

//   void _onMenuSelected(String menu) {
//     setState(() {
//       selectedMenu = menu;
//       isSidebarVisible = false; // সাইডবার ক্লোজ করতে চাইলে true রাখো
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: Row(
//           children: [
//             // Sidebar - width fixed
//             if (isSidebarVisible)
//               Container(
//                 width: 250,
//                 color: Colors.white,
//                 child: ListView(
//                   children: [
//                     Container(
//                       color: const Color.fromARGB(255, 10, 153, 5),
//                       height: 55,
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       child: Row(

//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Pharma',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.close, color: Colors.white),
//                             onPressed: () {
//                               setState(() => isSidebarVisible = false);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     ...menuItems.entries.map((entry) {
//                       if (entry.key == 'Manufacture') {
//                         return ExpansionTile(
//                           title: Text(entry.key),
//                           leading: Icon(entry.value),
//                           children: manufactureSubItems.entries.map((sub) {
//                             return ListTile(
//                               leading: Icon(sub.value, size: 20),
//                               title: Text(sub.key),
//                               onTap: () {
//                                 setState(() {
//                                   selectedMenu = sub.key;
//                                   isSidebarVisible = false;
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         );
//                       } else {
//                         return ListTile(
//                           leading: Icon(entry.value),
//                           title: Text(entry.key),
//                           selected: selectedMenu == entry.key,
//                           onTap: () {
//                             _onMenuSelected(entry.key);
//                           },
//                         );
//                       }
//                     }).toList(),

//                     const Divider(),

//                     ListTile(
//                       leading: const Icon(
//                         Icons.logout,
//                         color: Colors.red,
//                       ),
//                       title: const Text(
//                         'Logout',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                       onTap: () {
//                         Navigator.of(context).popUntil((route) => route.isFirst);
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginPage(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//             // Main Content Area
//             Expanded(
//               child: Column(
//                 children: [
//                   // Top Navbar for toggling sidebar
//                   Container(
//                     color: Colors.blue,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         if (!isSidebarVisible)
//                           IconButton(
//                             icon: const Icon(Icons.menu, color: Colors.white),
//                             onPressed: () {
//                               setState(() => isSidebarVisible = true);
//                             },
//                           ),
//                         Text(
//                           selectedMenu,
//                           style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(width: 48), // empty space for alignment
//                       ],
//                     ),
//                   ),
//                   // Page content - fill rest of screen
//                   Expanded(
//                     child: _getPageByMenu(selectedMenu),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//sidebar over;ay

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/admin/DailySales.dart';
import 'package:flutter_ecommerce/ui/admin/Dashboard.dart';
import 'package:flutter_ecommerce/ui/admin/OrderManagement.dart';
import 'package:flutter_ecommerce/widgets/MainLayout.dart';

/* class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool isSidebarVisible = false; // default sidebar hidden, overlay হয়ে আসবে
  String selectedMenu = 'Dashboard';

  final menuItems = {
    'Dashboard': Icons.dashboard,
    'Manufacture': Icons.precision_manufacturing,
    'Category': Icons.category,
    'Sub Category': Icons.subdirectory_arrow_right,
    'Medicines': Icons.medical_services,
    'Order Management': Icons.assignment,
    'Inventory': Icons.inventory,
    'Sales Report': Icons.bar_chart,
  };

  final manufactureSubItems = {
    'Raw Materials': Icons.bubble_chart,
    'Raw Material Supplier': Icons.group,
    'Raw Material Import': Icons.import_export,
    'Manufacturing': Icons.build_circle,
  };

  Widget _getPageByMenu(String menu) {
    switch (menu) {
      case 'Dashboard':
        return const DashboardPage();
      case 'Products':
        return ProductPage(
          onAddToCart: (Map<String, dynamic> item) {
            // Handle adding item to cart
            print('Item added to cart: $item');
          }, sortOrderIndex: 0, isDarkMode: false, products: [], searchQuery: '',
        );
      default:
        return Center(
          child: Text(
            '$menu Page Content',
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }

  void _onMenuSelected(String menu) {
    setState(() {
      selectedMenu = menu;
      isSidebarVisible = false; // sidebar hide on selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Top Navbar
                Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menu icon to open sidebar
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            isSidebarVisible = true;
                          });
                        },
                      ),
                      Text(
                        selectedMenu,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48), // space to balance row
                    ],
                  ),
                ),
                // Page content fill rest
                Expanded(child: _getPageByMenu(selectedMenu)),
              ],
            ),

            // Sidebar overlay
            if (isSidebarVisible)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                width: 250,
                child: Material(
                  elevation: 16,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 10, 153, 5),
                        height: 64,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'eShop Admin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSidebarVisible = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ...menuItems.entries.map((entry) {
                              if (entry.key == 'Manufacture') {
                                return ExpansionTile(
                                  title: Text(entry.key),
                                  leading: Icon(entry.value),
                                  children: manufactureSubItems.entries.map((
                                    sub,
                                  ) {
                                    return ListTile(
                                      leading: Icon(sub.value, size: 20),
                                      title: Text(sub.key),
                                      onTap: () {
                                        _onMenuSelected(sub.key);
                                      },
                                    );
                                  }).toList(),
                                );
                              } else {
                                return ListTile(
                                  leading: Icon(entry.value),
                                  title: Text(entry.key),
                                  selected: selectedMenu == entry.key,
                                  onTap: () {
                                    _onMenuSelected(entry.key);
                                  },
                                );
                              }
                            }),

                            const Divider(),

                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Dark translucent background when sidebar visible (for click outside to close)
            // if (isSidebarVisible)
            //   Positioned.fill(
            //     child: GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           isSidebarVisible = false;
            //         });
            //       },
            //       child: Container(
            //         color: Colors.black54,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
 */

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool isSidebarVisible = false;
  String selectedMenu = 'Dashboard';

  /// Main menu list (with icons)
  final menuItems = {
    'Dashboard': Icons.dashboard,
    'Category Management': Icons.folder,
    'Product Management': Icons.shopping_bag,
    'Sales Reports': Icons.bar_chart,
    'Seller Management': Icons.store,
    'Order Management': Icons.receipt,
    'User Management': Icons.people,
    'Inventory': Icons.inventory,
    'Coupon': Icons.card_giftcard,
    'Settings': Icons.settings,
  };

  /// Submenu items for expandable menus
  final categorySubItems = {
    'Category': Icons.category,
    'Subcategory': Icons.subdirectory_arrow_right,
  };

  final productSubItems = {
    'Add Product': Icons.add_box,
    'Product List': Icons.list,
  };

  final salesSubItems = {
    'Daily Sales': Icons.calendar_today,
    'Monthly Sales': Icons.date_range,
    'Yearly Sales': Icons.show_chart,
    'Top Products': Icons.star,
  };

  final sellerSubItems = {
    'Pending Sellers': Icons.hourglass_empty,
    'Approved Sellers': Icons.check_circle,
    'Blocked Sellers': Icons.block,
    'Seller Details': Icons.description,
  };

  // Widget _getPageByMenu(String menu) {
  //   switch (menu) {
  //     case 'Dashboard':
  //       return const DashboardPage();
  //     case 'Products':
  //       return ProductPage(
  //         onAddToCart: (Map<String, dynamic> item) {
  //           print('Item added to cart: $item');
  //         },
  //         sortOrderIndex: 0,
  //         isDarkMode: false,
  //         products: [],
  //         searchQuery: '',
  //       );
  //     default:
  //       return Center(
  //         child: Text(
  //           '$menu Page Content',
  //           style: const TextStyle(fontSize: 24),
  //         ),
  //       );
  //   }
  // }

  Widget _getPageByMenu(String menu) {
    switch (menu) {
      case 'Dashboard':
        return const DashboardPage();
      // case 'Add Product':
      //   return AddProductPage(); // jodi thake
      // case 'Product List':
      //   return ProductListPage(); // jodi thake
      case 'Daily Sales':
        return const SalesReportPage(); // ✅ Daily Sales page
      // case 'Monthly Sales':
      //   return const MonthlySalesPage(); // Optional
      // case 'Yearly Sales':
      //   return const YearlySalesPage();  // Optional
      // case 'Top Products':
      //   return const TopProductsPage();   // Optional
      case 'Order Management':
        return const OrderManagementPage(); // Optional
      default:
        return Center(
          child: Text(
            '$menu Page Content',
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }

  void _onMenuSelected(String menu) {
    setState(() {
      selectedMenu = menu;
      isSidebarVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            /// Main Content Area
            Column(
              children: [
                /// Top Navbar
                Container(
                  color: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            isSidebarVisible = true;
                          });
                        },
                      ),
                      Text(
                        selectedMenu,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(child: _getPageByMenu(selectedMenu)),
              ],
            ),

            /// Sidebar
            if (isSidebarVisible)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                width: 250,
                child: Material(
                  elevation: 16,
                  color: Colors.white,
                  child: Column(
                    children: [
                      /// Sidebar Header
                      Container(
                        color: Colors.deepOrange,
                        height: 64,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '🛡️ Admin Panel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSidebarVisible = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      /// Menu List
                      Expanded(
                        child: ListView(
                          children: [
                            ...menuItems.entries.map((entry) {
                              if (entry.key == 'Category Management') {
                                return ExpansionTile(
                                  title: Text(entry.key),
                                  leading: Icon(entry.value),
                                  children: categorySubItems.entries.map((sub) {
                                    return ListTile(
                                      leading: Icon(sub.value, size: 20),
                                      title: Text(sub.key),
                                      onTap: () => _onMenuSelected(sub.key),
                                    );
                                  }).toList(),
                                );
                              } else if (entry.key == 'Product Management') {
                                return ExpansionTile(
                                  title: Text(entry.key),
                                  leading: Icon(entry.value),
                                  children: productSubItems.entries.map((sub) {
                                    return ListTile(
                                      leading: Icon(sub.value, size: 20),
                                      title: Text(sub.key),
                                      onTap: () => _onMenuSelected(sub.key),
                                    );
                                  }).toList(),
                                );
                              } else if (entry.key == 'Sales Reports') {
                                return ExpansionTile(
                                  title: Text(entry.key),
                                  leading: Icon(entry.value),
                                  children: salesSubItems.entries.map((sub) {
                                    return ListTile(
                                      leading: Icon(sub.value, size: 20),
                                      title: Text(sub.key),
                                      onTap: () => _onMenuSelected(sub.key),
                                    );
                                  }).toList(),
                                );
                              } else if (entry.key == 'Seller Management') {
                                return ExpansionTile(
                                  title: Text(entry.key),
                                  leading: Icon(entry.value),
                                  children: sellerSubItems.entries.map((sub) {
                                    return ListTile(
                                      leading: Icon(sub.value, size: 20),
                                      title: Text(sub.key),
                                      onTap: () => _onMenuSelected(sub.key),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return ListTile(
                                  leading: Icon(entry.value),
                                  title: Text(entry.key),
                                  selected: selectedMenu == entry.key,
                                  onTap: () => _onMenuSelected(entry.key),
                                );
                              }
                            }),

                            const Divider(),

                            /// Logout
                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    // builder: (context) => const LoginPage(),
                                    builder: (context) => const MainLayout(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
