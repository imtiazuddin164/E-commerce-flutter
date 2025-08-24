import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/CartPage.dart';
import 'package:flutter_ecommerce/ui/HomePage.dart';
import 'package:flutter_ecommerce/ui/ProductPage.dart';
import 'package:flutter_ecommerce/ui/ProfilePage.dart';

/* 
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<String> _titles = [
    "Home",
    // "Categories",
    "Products",
    "Cart",
    "Profile",
  ];

  final List<Widget> _pages = [
    HomePage(),
    // CategoriesPage(),
    const ProductPage(),
    const CartPage(cartItems: []),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("eShop"),
        toolbarHeight: 60,
        // centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        // backgroundColor: const Color.fromARGB(255, 46, 128, 61),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          // Current page name bar below AppBar
          Container(
            width: double.infinity,
            color: Colors.deepOrange.shade100,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'You are on the ${_titles[_currentIndex]} page',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange.shade900,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),

          // Expanded page content
          Expanded(child: _pages[_currentIndex]),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          iconSize: 26,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category),
              // label: "Categories",
              label: "All Products",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
 */

//Working Second Version

/* class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // 🔹 এখানে cartItems MainLayout-এ রাখা হলো
  List<Map<String, dynamic>> cartItems = [];

  // final List<String> _titles = ["Home", "Products", "Cart", "Profile"];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildCartIcon(IconData iconData) {
  return Stack(
    children: [
      Icon(iconData),
      if (cartItems.isNotEmpty)
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              cartItems.length.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    // 🔹 _pages এখন dynamic যাতে cartItems পাঠানো যায়
    final List<Widget> _pages = [
      HomePage(),
      ProductPage(
        onAddToCart: (product) {
          setState(() {
            cartItems.add(product);
          });
        },
      ),
      CartPage(cartItems: cartItems),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("eShop"),
        toolbarHeight: 60,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),

          /*           // 🔹 Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  _onTabTapped(2); // Cart ট্যাবে যাবে
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ), */
        ],
      ),

      body: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   color: Colors.deepOrange.shade100,
          //   padding: const EdgeInsets.symmetric(vertical: 8),
          //   child: Text(
          //     'You are on the ${_titles[_currentIndex]} page',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.deepOrange.shade900,
          //       fontWeight: FontWeight.w600,
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: 26,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_outlined),
            activeIcon: const Icon(Icons.category),
            label: "All Products",
          ),

          BottomNavigationBarItem(
            icon: buildCartIcon(Icons.shopping_cart_outlined),
            activeIcon: buildCartIcon(Icons.shopping_cart),
            label: "Cart",
          ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  
}
 */

/* class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // 🔹 এখানে cartItems MainLayout-এ রাখা হলো
  List<Map<String, dynamic>> cartItems = [];

  // 🔹 Dark mode / Sort / Search (MainLayout level)
  bool isDarkMode = false;
  int currentSortOrderIndex = 0; // 0 = none, 1 = priceAsc, 2 = priceDesc
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  

  Widget buildCartIcon(IconData iconData) {
    return Stack(
      children: [
        Icon(iconData),
        if (cartItems.isNotEmpty)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                cartItems.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // ✅ search controller dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 _pages এখন dynamic যাতে cartItems পাঠানো যায়
    final List<Widget> _pages = [
      HomePage(),
      ProductPage(
        onAddToCart: (product) {
          setState(() {
            cartItems.add(product);
          });
        },
      ),
      CartPage(cartItems: cartItems),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("eShop"),
        toolbarHeight: 60,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          // 🔹 Dark Mode Toggle
          IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            tooltip: 'Toggle Dark Mode',
          ),

          // 🔹 Sort Menu
          PopupMenuButton<int>(
            onSelected: (value) {
              setState(() {
                currentSortOrderIndex = value; // 0,1,2
              });
            },
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 0,
                child: Text('No Sorting'),
              ),
              PopupMenuItem(
                value: 1,
                child: Text('Price: Low to High'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Price: High to Low'),
              ),
            ],
          ),

          // (তোমার আগের আইকনগুলো রেখে দিয়েছি)
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],

        // 🔹 Search Bar in AppBar (bottom)
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // এখন শুধু স্টোর করছি
                });
              },
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white, // এখানে থিম-ডিপেন্ডেন্ট করতে চাইলে উপরেই করব
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: 26,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_outlined),
            activeIcon: const Icon(Icons.category),
            label: "All Products",
          ),
          BottomNavigationBarItem(
            icon: buildCartIcon(Icons.shopping_cart_outlined),
            activeIcon: buildCartIcon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
 */

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> cartItems = [];

  bool isDarkMode = false;
  int currentSortOrderIndex = 0; // 0 = none, 1 = priceAsc, 2 = priceDesc
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildCartIcon(IconData iconData) {
    return Stack(
      children: [
        Icon(iconData),
        if (cartItems.isNotEmpty)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                cartItems.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Widget> _pages = [
    //   HomePage(),
    //   ProductPage(
    //     searchQuery: _searchQuery,                // ✅ নতুন প্যারামিটার
    //     sortOrderIndex: currentSortOrderIndex,    // ✅ নতুন প্যারামিটার
    //     onAddToCart: (product) {
    //       setState(() {
    //         cartItems.add(product);
    //       });
    //     },
    //   ),
    //   CartPage(cartItems: cartItems),
    //   ProfilePage(),
    // ];
    final List<Widget> _pages = [
      HomePage(),
      ProductPage(
        searchQuery: _searchQuery,
        sortOrderIndex: currentSortOrderIndex, // ✅ এখন পাঠানো হবে
        isDarkMode: isDarkMode, // ✅ এখন পাঠানো হবে
        onAddToCart: (product) {
          setState(() {
            cartItems.add(product);
          });
        },
        products: [],
      ),
      CartPage(cartItems: cartItems),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("eShop"),
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 255, 93, 18),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            tooltip: 'Toggle Dark Mode',
          ),
          PopupMenuButton<int>(
            onSelected: (value) {
              setState(() {
                currentSortOrderIndex = value; // 0,1,2
              });
            },
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 0, child: Text('No Sorting')),
              PopupMenuItem(value: 1, child: Text('Price: Low to High')),
              PopupMenuItem(value: 2, child: Text('Price: High to Low')),
            ],
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // ✅ শুধু স্টোর করছি
                });
              },
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
      body: Column(children: [Expanded(child: _pages[_currentIndex])]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: 26,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: "All Products",
          ),
          BottomNavigationBarItem(
            icon: buildCartIcon(Icons.shopping_cart_outlined),
            activeIcon: buildCartIcon(Icons.shopping_cart),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
