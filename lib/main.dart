import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/SalesReport.dart';
import 'package:flutter_ecommerce/service/SalesReportService.dart';

// main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primaryColor: Colors.greenAccent),
//       darkTheme: ThemeData(primaryColor: Colors.amberAccent),
//       color: Colors.blueAccent,
//       debugShowCheckedModeBanner: false,
//       home: HomeActivity(),
//     );
//   }
// }

// class HomeActivity extends StatelessWidget {
//   const HomeActivity({super.key});

//   MySnackBar(message, context) {
//     return ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('eShop'),
//         titleSpacing: 15,
//         // centerTitle: true,
//         toolbarHeight: 70,
//         toolbarOpacity: 0.8,
//         elevation: 10,
//         foregroundColor: Colors.white,
//         backgroundColor: const Color.fromARGB(255, 46, 128, 61),
//         actions: [
//           IconButton(
//             onPressed: () {
//               MySnackBar("This is Search", context);
//             },
//             icon: Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: () {
//               MySnackBar("This is Comments", context);
//             },
//             icon: Icon(Icons.comment),
//           ),
//           IconButton(
//             onPressed: () {
//               MySnackBar("This is Notificatios", context);
//             },
//             icon: Icon(Icons.notifications),
//           ),
//           IconButton(
//             onPressed: () {
//               MySnackBar("This is Shopping Cart", context);
//             },
//             icon: Icon(Icons.shopping_cart),
//           ),
//         ],
//       ),
//       body: Center(child: const Text('Welcome to the Home Activity!')),
//       // drawer: (),
//       // endDrawer:,
//       // bottomNavigationBar: (),
//       // floatingActionButton: (),
//     );
//   }
// }


import 'package:flutter_ecommerce/widgets/MainLayout.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ProductProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'E-commerce Application',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       // home: CheckoutPage(),
//       home: ProductPage(),
//       // home: PaymentPage(),
//       // home: InvoicePage(),
//       // home: SignUp(),
//       // home: ProductShowcasePage(),
//       //  home:  ProductGridPage(),
//       // home:HomeScreen(),
//     );
//   }
// }




// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SalesReportProvider(SalesReportService()),
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const MainLayout(),
        //  home: ProductPage(),
        // home: RegisterPage(),
    );
  }
}

