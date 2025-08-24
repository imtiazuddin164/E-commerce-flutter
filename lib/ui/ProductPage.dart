import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/ProductDetails.dart';
import 'package:http/http.dart' as http;

// First Code
/* 
class ProductPage extends StatefulWidget {
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Product List')),
  //     body: Consumer<ProductProvider>(
  //       builder: (context, productProvider, child) {
  //         if (productProvider.product.isEmpty) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //         return ListView.builder(
  //           itemCount: productProvider.product.length,
  //           itemBuilder: (context, index) {
  //             final product = productProvider.product[index];
  //             return Card(
  //               elevation: 2,
  //               margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //               child: ListTile(
  //                 title: Text(
  //                   product.productName.toString(),
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 subtitle: Text(
  //                   product.price.toString(),
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),

  //                 trailing: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     IconButton(
  //                       icon: Icon(Icons.edit, color: Colors.blue),
  //                       onPressed: () => _showEditDialog(context, product),
  //                     ),
  //                     IconButton(
  //                       icon: Icon(Icons.delete, color: Colors.red),
  //                       onPressed: () =>
  //                           _showDeleteConfirmation(context, product),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () => _showAddDialog(context),
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Product List')),
    body: Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.product.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: productProvider.product.length,
          itemBuilder: (context, index) {
            final product = productProvider.product[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Name: ${product.productName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Product Code: ${product.productCode}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Category: ${product.categoryName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Stock: ${product.stock}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                     Text(
                      'Price: ${product.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditDialog(context, product),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmation(context, product),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _showAddDialog(context),
      child: Icon(Icons.add),
    ),
  );
}

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String productName = '';
        String productCode = '';
        String categoryName = '';
        String stock = '';
        String price = '';

        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Product Name'),
                onChanged: (value) => productName = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Product Code'),
                onChanged: (value) => productCode = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Category'),
                onChanged: (value) => categoryName = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Stock'),
                onChanged: (value) => stock = value,
              ),
               TextField(
                decoration: InputDecoration(hintText: 'Price'),
                onChanged: (value) => price = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (productName.isNotEmpty) {
                  context.read<ProductProvider>().addProduct(
                    Product(
                      productName: productName,
                      productCode: productCode,
                      categoryName: categoryName,
                      stock: int.tryParse(stock),
                      price: double.tryParse(price),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String productName = product.productName ?? '';
        String productCode = product.productCode ?? '';
        String categoryName = product.categoryName ?? '';
        String stock = product.stock !=null? product.stock.toString(): '';
        String price = product.price != null ? product.price.toString() : '';
        return AlertDialog(
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Product Name'),
                onChanged: (value) => productName = value,
                controller: TextEditingController(text: productName),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Product Code'),
                onChanged: (value) => productCode = value,
                controller: TextEditingController(text: productCode),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Category Name'),
                onChanged: (value) => categoryName = value,
                controller: TextEditingController(text: categoryName),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Stock'),
                onChanged: (value) => stock = value,
                controller: TextEditingController(text: stock),
              ),
               TextField(
                decoration: InputDecoration(hintText: 'Price'),
                onChanged: (value) => price = value,
                controller: TextEditingController(text: price),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (productName.isNotEmpty) {
                  context.read<ProductProvider>().updateProduct(
                    Product(
                      id: product.id,
                      productName: productName,
                      productCode: productCode,
                      categoryName: categoryName,
                      stock: stock.isNotEmpty ? int.tryParse(stock) : null,
                      price: price.isNotEmpty ? double.tryParse(price) : null,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                context.read<ProductProvider>().deleteProduct(product.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
 */

// Second code

/* class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];

  // Change this to your Spring Boot API base URL
  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final imageUrl =
                    '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Text(product['productName'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category Name: ${product['categoryName'] ?? ''}"),
                        Text("Subcategory Name: ${product['subcategoryName'] ?? ''}",),
                        Text("Price: ${product['price'] ?? ''}"),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
} 
*/

// Third code

/* class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];
  List<Map<String, dynamic>> cartItems = [];

  final String baseUrl = "http://localhost:8080"; // Change to your IP if needed

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final imageUrl =
                    '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image part
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          imageUrl,
                          height: 320, // Increased height
                          width: double.infinity,
                          // fit: BoxFit.fill, // Fill the card area
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                              height: 320,
                              width: double.infinity,
                              // fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      // Text part
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productName'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Category: ${product['categoryName'] ?? ''}",
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Subcategory: ${product['subcategoryName'] ?? ''}",
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "৳${product['price'] ?? ''}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Add to Cart Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    cartItems.add({
                                      'name': product['productName'],
                                      'price': product['price'],
                                      'imageUrl': imageUrl,
                                    });
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CartPage(cartItems: cartItems),
                                    ),
                                  );
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text("Add to Cart"),
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
  }
} */

// Fourth code

/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'CartPage.dart'; // Ensure this exists

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];
  List<Map<String, dynamic>> cartItems = [];

  final String baseUrl = "http://localhost:8080"; // Change to your server IP

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;
                double childAspectRatio = 0.65;

                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 900) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageUrl =
                        '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image part
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              imageUrl,
                              height: 320,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                  height: 320,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          // Text part
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['productName'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Category: ${product['categoryName'] ?? ''}",
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Subcategory: ${product['subcategoryName'] ?? ''}",
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "৳${product['price'] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        cartItems.add({
                                          'name': product['productName'],
                                          'price': product['price'],
                                          'imageUrl': imageUrl,
                                        });
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CartPage(cartItems: cartItems),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text("Add to Cart"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
} */

// Fifth code

/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CartPage.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];
  List<Map<String, dynamic>> cartItems = [];

  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;

                // ✅ Responsive breakpoints
                if (constraints.maxWidth >= 1024) {
                  crossAxisCount = 4; // Desktop
                } else if (constraints.maxWidth >= 768) {
                  crossAxisCount = 3; // Tablet
                } else {
                  crossAxisCount = 2; // Mobile (360px +)
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.60,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageUrl =
                        '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image part
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  imageUrl,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "10% OFF",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // Text part
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['productName'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Category: ${product['categoryName'] ?? ''}",
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Subcategory: ${product['subcategoryName'] ?? ''}",
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "৳${product['price'] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        cartItems.add({
                                          'name': product['productName'],
                                          'price': product['price'],
                                          'imageUrl': imageUrl,
                                        });
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CartPage(cartItems: cartItems),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text("Add to Cart"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
} */

//sixth code

/* import 'dart:convert';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];
  List<Map<String, dynamic>> cartItems = [];

  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  int calculateCrossAxisCount(double width) {
    if (width < 400) return 2;
    if (width < 600) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.green,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: calculateCrossAxisCount(screenWidth),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.62, // fixed card ratio
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final imageUrl =
                    '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                imageUrl,
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                    height: 130,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['productName'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Category: ${product['categoryName'] ?? ''}",
                                    style: const TextStyle(fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Subcategory: ${product['subcategoryName'] ?? ''}",
                                    style: const TextStyle(fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "৳${product['price'] ?? ''}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                cartItems.add({
                                  'name': product['productName'],
                                  'price': product['price'],
                                  'imageUrl': imageUrl,
                                });
                              });

                              // Navigate to cart page
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text("Add to Cart"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
 */

//overflow fixed and Working Code
/* 
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

enum SortOrder { none, priceAsc, priceDesc }

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  List<Map<String, dynamic>> cartItems = [];

  final String baseUrl = "http://localhost:8080";

  bool isDarkMode = false;
  SortOrder currentSortOrder = SortOrder.none;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        final name = (product['productName'] ?? '').toString().toLowerCase();
        return name.contains(query);
      }).toList();
      _applySorting();
    });
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          filteredProducts = List.from(allProducts);
          _applySorting();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _applySorting() {
    if (currentSortOrder == SortOrder.priceAsc) {
      filteredProducts.sort(
        (a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0),
      );
    } else if (currentSortOrder == SortOrder.priceDesc) {
      filteredProducts.sort(
        (a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0),
      );
    }
  }

  void _changeSortOrder(SortOrder order) {
    setState(() {
      currentSortOrder = order;
      _applySorting();
    });
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    int getCrossAxisCount(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      if (width > 1200) return 4; // Desktop
      if (width > 800) return 3; // Tablet
      return 2; // Mobile
    }

    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Available Products'),
          backgroundColor: isDarkMode
              ? Colors.grey[900]
              : const Color.fromARGB(255, 19, 143, 15),
          centerTitle: true,
          elevation: 4,
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: _toggleDarkMode,
            ),
            PopupMenuButton<SortOrder>(
              onSelected: _changeSortOrder,
              icon: const Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: SortOrder.none,
                  child: Text('No Sorting'),
                ),
                const PopupMenuItem(
                  value: SortOrder.priceAsc,
                  child: Text('Price: Low to High'),
                ),
                const PopupMenuItem(
                  value: SortOrder.priceDesc,
                  child: Text('Price: High to Low'),
                ),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
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
        body: filteredProducts.isEmpty
            ? const Center(child: Text('No products found.'))
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(context),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    final imageUrl =
                        '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                    return Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              imageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['productName'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                // const SizedBox(height: 4),
                                // Text("Category: ${product['category'] ?? ''}",
                                //     style: const TextStyle(fontSize: 12)),
                                //const SizedBox(height: 6),
                                // Text(
                                //   "Stock: ${product['stock'] ?? ''}",
                                //   style: const TextStyle(fontSize: 12),
                                // ),
                                const SizedBox(height: 6),
                                Text(
                                  "৳${product['price'] ?? '0'}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    cartItems.add({
                                      'name': product['productName'],
                                      'price': product['price'],
                                      'imageUrl': imageUrl,
                                    });
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CartPage(cartItems: cartItems),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    255,
                                    93,
                                    18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: cartItems.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(cartItems: cartItems),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: Text(cartItems.length.toString()),
                backgroundColor: const Color.fromARGB(255, 13, 124, 96),
              ),
      ),
    );
  }
}
 */

// # Anather code snippet

/* 
class ProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // 🔹 Cart add callback

  const ProductPage({super.key, required this.onAddToCart});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

enum SortOrder { none, priceAsc, priceDesc }

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  final String baseUrl = "http://localhost:8080";
  bool isDarkMode = false;
  SortOrder currentSortOrder = SortOrder.none;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ... আগের কোড একই থাকবে fetchProducts, sorting ইত্যাদি ...

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        final name = (product['productName'] ?? '').toString().toLowerCase();
        return name.contains(query);
      }).toList();
      _applySorting();
    });
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          filteredProducts = List.from(allProducts);
          _applySorting();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _applySorting() {
    if (currentSortOrder == SortOrder.priceAsc) {
      filteredProducts.sort(
        (a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0),
      );
    } else if (currentSortOrder == SortOrder.priceDesc) {
      filteredProducts.sort(
        (a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0),
      );
    }
  }

  void _changeSortOrder(SortOrder order) {
    setState(() {
      currentSortOrder = order;
      _applySorting();
    });
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    int getCrossAxisCount(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      if (width > 1200) return 4;
      if (width > 800) return 3;
      return 2;
    }

    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Available Products'),
          backgroundColor: isDarkMode
              ? Colors.grey[900]
              : const Color.fromARGB(255, 19, 143, 15),
          centerTitle: true,
          elevation: 4,
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: _toggleDarkMode,
            ),
            PopupMenuButton<SortOrder>(
              onSelected: _changeSortOrder,
              icon: const Icon(Icons.sort),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: SortOrder.none,
                  child: Text('No Sorting'),
                ),
                const PopupMenuItem(
                  value: SortOrder.priceAsc,
                  child: Text('Price: Low to High'),
                ),
                const PopupMenuItem(
                  value: SortOrder.priceDesc,
                  child: Text('Price: High to Low'),
                ),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
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
        body: filteredProducts.isEmpty
            ? const Center(child: Text('No products found.'))
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(context),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    final imageUrl =
                        '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                    return Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              imageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['productName'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "৳${product['price'] ?? '0'}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.onAddToCart({
                                    'name': product['productName'],
                                    'price': product['price'],
                                    'imageUrl': imageUrl,
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    255,
                                    93,
                                    18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
 */

//last code snippet

/* class ProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // 🔹 Cart add callback

  const ProductPage({super.key, required this.onAddToCart});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

enum SortOrder { none, priceAsc, priceDesc }

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  final String baseUrl = "http://localhost:8080";
  SortOrder currentSortOrder = SortOrder.none;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          filteredProducts = List.from(allProducts);
          _applySorting();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _applySorting() {
    if (currentSortOrder == SortOrder.priceAsc) {
      filteredProducts.sort(
        (a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0),
      );
    } else if (currentSortOrder == SortOrder.priceDesc) {
      filteredProducts.sort(
        (a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int getCrossAxisCount(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      if (width > 1200) return 4;
      if (width > 800) return 3;
      return 2;
    }

    return Scaffold(
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCrossAxisCount(context),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final imageUrl =
                      '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['productName'] ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "৳${product['price'] ?? '0'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onAddToCart({
                                  'name': product['productName'],
                                  'price': product['price'],
                                  'imageUrl': imageUrl,
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  93,
                                  18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
 */

/* class ProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // 🔹 Cart add callback
  final String searchQuery; // 🔹 Search input
  final int sortOrder; // 🔹 Sort order index
  final bool isDarkMode;

  const ProductPage({
    super.key,
    required this.onAddToCart,
    this.searchQuery = '',
    this.sortOrder = 0, required int sortOrderIndex, required this.isDarkMode,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  void didUpdateWidget(covariant ProductPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.sortOrder != widget.sortOrder) {
      _filterAndSortProducts();
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          _filterAndSortProducts();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _filterAndSortProducts() {
    List<dynamic> temp = allProducts.where((product) {
      return product['productName']
          .toString()
          .toLowerCase()
          .contains(widget.searchQuery.toLowerCase());
    }).toList();

    if (widget.sortOrder == 1) {
      temp.sort((a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0));
    } else if (widget.sortOrder == 2) {
      temp.sort((a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0));
    }

    setState(() {
      filteredProducts = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    int getCrossAxisCount(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      if (width > 1200) return 4;
      if (width > 800) return 3;
      return 2;
    }

    return Scaffold(
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCrossAxisCount(context),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final imageUrl =
                      '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['productName'] ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "৳${product['price'] ?? '0'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onAddToCart({
                                  'name': product['productName'],
                                  'price': product['price'],
                                  'imageUrl': imageUrl,
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  93,
                                  18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
 */

//last code snippet

/* class ProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // Cart add callback
  final String searchQuery; // Search input
  final int sortOrder; // Sort order index
  final bool isDarkMode;

  const ProductPage({
    super.key,
    required this.onAddToCart,
    this.searchQuery = '',
    this.sortOrder = 0,
    required int sortOrderIndex,
    required this.isDarkMode,
    required List products,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  void didUpdateWidget(covariant ProductPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.sortOrder != widget.sortOrder) {
      _filterAndSortProducts();
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          _filterAndSortProducts();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _filterAndSortProducts() {
    List<dynamic> temp = allProducts.where((product) {
      return product['productName'].toString().toLowerCase().contains(
        widget.searchQuery.toLowerCase(),
      );
    }).toList();

    if (widget.sortOrder == 1) {
      temp.sort((a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0));
    } else if (widget.sortOrder == 2) {
      temp.sort((a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0));
    }

    setState(() {
      filteredProducts = temp;
    });
  }

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCrossAxisCount(context),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: MediaQuery.of(context).size.width > 800
                      ? 0.72
                      : 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final imageUrl =
                      '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Image full-size responsive
                        AspectRatio(
                          aspectRatio: 1, // 1:1 for consistency
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          ),
                        ),

                        // 🔹 Prevent overflow with Expanded
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['productName'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "৳${product['price'] ?? '0'}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green[700],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onAddToCart({
                                        'name': product['productName'],
                                        'price': product['price'],
                                        'imageUrl': imageUrl,
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        255,
                                        93,
                                        18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
 */

/* // ===================== ProductPage =====================
class ProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final String searchQuery;
  final int sortOrder;
  final bool isDarkMode;

  const ProductPage({
    super.key,
    required this.onAddToCart,
    this.searchQuery = '',
    this.sortOrder = 0,
    required int sortOrderIndex,
    required this.isDarkMode,
    required List products,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  void didUpdateWidget(covariant ProductPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.sortOrder != widget.sortOrder) {
      _filterAndSortProducts();
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          _filterAndSortProducts();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _filterAndSortProducts() {
    List<dynamic> temp = allProducts.where((product) {
      return product['productName'].toString().toLowerCase().contains(
        widget.searchQuery.toLowerCase(),
      );
    }).toList();

    if (widget.sortOrder == 1) {
      temp.sort((a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0));
    } else if (widget.sortOrder == 2) {
      temp.sort((a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0));
    }

    setState(() {
      filteredProducts = temp;
    });
  }

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCrossAxisCount(context),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: MediaQuery.of(context).size.width > 800
                      ? 0.72
                      : 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final mainImage =
                      '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ProductDetailsPage(product: product),
                      //   ),
                      // );
                      // ProductPage এর card onTap এ
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                            onAddToCart: (prod) {
                              // ProductPage এর onAddToCart callback reuse করা
                              widget.onAddToCart(prod);
                            },
                            onBuyNow: (prod) {
                              // এখানেও BuyNow logic handle করতে পারো
                              // উদাহরণস্বরূপ:
                              print("Buying now: ${prod['productName']}");
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                mainImage,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                      'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['productName'] ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "৳${product['price'] ?? '0'}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.onAddToCart({
                                          'name': product['productName'],
                                          'price': product['price'],
                                          'imageUrl': mainImage,
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          255,
                                          93,
                                          18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                },
              ),
            ),
    );
  }
}
 */




class ProductPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final String searchQuery;
  final int sortOrder;
  final bool isDarkMode;

  const ProductPage({
    super.key,
    required this.onAddToCart,
    this.searchQuery = '',
    this.sortOrder = 0,
    required int sortOrderIndex,
    required this.isDarkMode,
    required List products,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  final String baseUrl = "http://localhost:8080";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  void didUpdateWidget(covariant ProductPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.sortOrder != widget.sortOrder) {
      _filterAndSortProducts();
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/product'));
      if (response.statusCode == 200) {
        setState(() {
          allProducts = json.decode(response.body);
          _filterAndSortProducts();
        });
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _filterAndSortProducts() {
    List<dynamic> temp = allProducts.where((product) {
      return product['productName']
          .toString()
          .toLowerCase()
          .contains(widget.searchQuery.toLowerCase());
    }).toList();

    if (widget.sortOrder == 1) {
      temp.sort((a, b) => (a['price'] ?? 0).compareTo(b['price'] ?? 0));
    } else if (widget.sortOrder == 2) {
      temp.sort((a, b) => (b['price'] ?? 0).compareTo(a['price'] ?? 0));
    }

    setState(() {
      filteredProducts = temp;
    });
  }

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    return 2;
  }

  void _handleAddToCart(Map<String, dynamic> product, String mainImage) {
    final cartProduct = {
      'name': product['productName'] ?? '',
      'price': product['price'] ?? 0,
      'imageUrl': mainImage,
    };
    widget.onAddToCart(cartProduct);

    // Snackbar দেখানো
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product['productName']} added to cart"),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCrossAxisCount(context),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 800 ? 0.72 : 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final mainImage =
                      '$baseUrl/image/${product["mainImage"] ?? "default.jpg"}';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                            onAddToCart: (prod) {
                              _handleAddToCart(prod, mainImage);
                            },
                            onBuyNow: (prod) {
                              print("Buying now: ${prod['productName']}");
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                mainImage,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['productName'] ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "৳${product['price'] ?? '0'}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _handleAddToCart(product, mainImage);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          255,
                                          93,
                                          18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                },
              ),
            ),
    );
  }
}
