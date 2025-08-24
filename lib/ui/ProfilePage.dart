import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/auth/Signup.dart';
import 'package:flutter_ecommerce/ui/auth/AuthService.dart';
import 'package:flutter_ecommerce/ui/auth/Login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;

  String? userName;
  String? userEmail;
  final String profileImageAsset = "assets/images/cd-258180.jpg";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await AuthService().getName(); // prefs: 'name'
    final email = await AuthService().getUseremail(); // prefs: 'username'
    setState(() {
      isLoggedIn = userName != null;
      userName = name;
      userEmail = email; // ✅ এখানে ঠিক করা হলো
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: isLoggedIn ? _buildProfileView() : _buildLoginSignupView(),
    );
  }

  Widget _buildProfileView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImageAsset),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName ?? userEmail ?? 'User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (userEmail != null)
                Text(userEmail!, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const Divider(height: 40),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text("My Orders"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text("Wishlist"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text("Address Book"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text("Logout"),
          onTap: () async {
            await AuthService().logout();
            setState(() {
              isLoggedIn = false;
              userName = null;
              userEmail = null;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Logged out')));
          },
        ),
      ],
    );
  }

  Widget _buildLoginSignupView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Hello, Welcome to eShop!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please login or sign up to continue",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final didLogin = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
                if (didLogin == true) {
                  await _loadUser();
                }
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false; // এখানে ইউজারের লগইন স্ট্যাটাস কন্ট্রোল করবে

  String? userName; // name prefs থেকে আসবে
  String? userEmail; // username prefs থেকে আসবে
  final String profileImageAsset =
      "assets/images/cd-258180.jpg"; // asset হলে এটাই রাখো

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: isLoggedIn ? _buildProfileView() : _buildLoginSignupView(),
    );
  }

  // ✅ লগইন করা থাকলে এই UI দেখাবে
  Widget _buildProfileView() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImageAsset),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName ?? userEmail ?? 'User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // ইমেইল prefs-এ নেই, তাই username দেখাও বা হাইড করো:
              if (userEmail != null)
                Text(userEmail!, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Divider(height: 40),

        //     userName,
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        // ),
        // Center(
        //   child: Text(userEmail, style: TextStyle(color: Colors.grey)),
        // ),
        // Divider(height: 40),
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: Text("My Orders"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("Wishlist"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Address Book"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text("Logout"),
          // onTap: () {
          //   setState(() {
          //     isLoggedIn = false;
          //   });
          // },
          onTap: () async {
            await AuthService().logout();
            setState(() {
              isLoggedIn = false;
              userName = null;
              userEmail = null;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Logged out')));
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await AuthService().getName(); // prefs: 'name'
    final username = await AuthService().getUsername(); // prefs: 'username'
    setState(() {
      isLoggedIn = username != null;
      userName = name;
      userEmail = userEmail;
    });
  }

  // ❌ লগইন না থাকলে এই UI দেখাবে
  Widget _buildLoginSignupView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "Hello, Welcome to eShop!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Please login or sign up to continue",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              // onPressed: () {
              // setState(() {
              //   isLoggedIn = true; // ডেমো জন্য লগইন true করলাম
              // });
              onPressed: () async {
                final didLogin = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
                if (didLogin == true) {
                  await _loadUser(); // লগইন হলে প্রোফাইল রিফ্রেশ
                }
              },
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
