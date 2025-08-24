import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/ProductPage.dart';
import 'package:flutter_ecommerce/ui/auth/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String? name;
  String? username;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      username = prefs.getString('username');
    });
  }

  void _logout() async {
    final authService = AuthService();
    await authService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, $name!', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text('Username: $username', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                 MaterialPageRoute(
                builder: (context) => ProductPage(onAddToCart: (Map<String, dynamic> cartItem) {  }, sortOrderIndex: 0, isDarkMode: false, products: [], searchQuery: '',), // Replace NewScreen with your target page
                ),
                );
              },
              icon: Icon(Icons.local_hospital),
              label: Text("Browse Products"),
            ),
          ],
        ),
      ),
    );
  }
}
