import 'package:flutter/material.dart';

// ===================== ProductDetailsPage =====================
/* class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product['mainImage'] != null
        ? 'http://localhost:8080/image/${product['mainImage']}'
        : 'assets/images/apple-iphone-15-plus-black-official-image.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        // title: Text(product['productName'] ?? 'Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/apple-iphone-15-plus-black-official-image.jpg',
                          fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product['productName'] ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "৳${product['price'] ?? '0'}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product['description'] ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
} */

/* import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showImageModal = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final imageUrl = product['mainImage'] != null
        ? 'http://localhost:8080/image/${product['mainImage']}'
        : 'assets/images/apple-iphone-15-plus-black-official-image.jpg';

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= Main Section =================
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 800;
                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---- Product Image ----
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showImageModal = true;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              height: 350,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                    fit: BoxFit.cover,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32, height: 32),
                      // ---- Product Info ----
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productName'] ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Price: ৳${product['price'] ?? 0}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF57224),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Product Code: ${product['productCode'] ?? ''}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product['stock'] != null && product['stock'] > 0
                                  ? "✅ In Stock"
                                  : "❌ Out of Stock",
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    product['stock'] != null &&
                                        product['stock'] > 0
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Sold by: ${product['sellerName'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "⭐ ${product['avgRating'] ?? 0} / 5 (${product['reviewCount'] ?? 0} reviews)",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            // ---- Buttons ----
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => widget.onBuyNow(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF57224),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🚀 Buy Now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => widget.onAddToCart(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF007BFF),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🛒 Add to Cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // ================= Description Section =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "📃 Description",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(thickness: 2, color: Color(0xFFF57224)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product['description'] ?? 'No description available.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // ================= Image Modal =================
            if (showImageModal)
              GestureDetector(
                onTap: () {
                  setState(() {
                    showImageModal = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
 */

/* 
class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onBuyNow;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showImageModal = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final imageUrl = product['mainImage'] != null
        ? 'http://localhost:8080/image/${product['mainImage']}'
        : 'assets/images/apple-iphone-15-plus-black-official-image.jpg';

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= Main Section =================
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 800;
                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // prevent unbounded height
                    children: [
                      // ---- Product Image ----
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showImageModal = true;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32, height: 32),
                      // ---- Product Info ----
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productName'] ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Price: ৳${product['price'] ?? 0}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF57224),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Product Code: ${product['productCode'] ?? ''}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product['stock'] != null &&
                                      product['stock'] > 0
                                  ? "✅ In Stock"
                                  : "❌ Out of Stock",
                              style: TextStyle(
                                fontSize: 16,
                                color: product['stock'] != null &&
                                        product['stock'] > 0
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Sold by: ${product['sellerName'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "⭐ ${product['avgRating'] ?? 0} / 5 (${product['reviewCount'] ?? 0} reviews)",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            // ---- Buttons ----
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: 
                                  (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => widget.onBuyNow(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF57224),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🚀 Buy Now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: 
                                  (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => widget.onAddToCart(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF007BFF),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🛒 Add to Cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // ================= Description Section =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "📃 Description",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(thickness: 2, color: Color(0xFFF57224)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product['description'] ?? 'No description available.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // ================= Image Modal =================
            if (showImageModal)
              GestureDetector(
                onTap: () {
                  setState(() {
                    showImageModal = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: InteractiveViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
 */

import 'package:flutter_ecommerce/ui/CartPage.dart';
import 'package:flutter_ecommerce/ui/CheckoutPage.dart';

/* class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({
    super.key,
    required this.product, required Null Function(dynamic prod) onAddToCart, required Null Function(dynamic prod) onBuyNow,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showImageModal = false;
  final List<Map<String, dynamic>> _cart = []; // simple cart list

  // void _addToCart(Map<String, dynamic> product) {
  //   setState(() {
  //     _cart.add(product);
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("${product['productName']} added to cart")),
  //   );

  //   // Navigate to Cart Page after adding
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => CartPage(cartItems: _cart),
  //     ),
  //   );
  // }

  void _addToCart(Map<String, dynamic> product) {
  final cartProduct = {
    'name': product['productName'] ?? 'Unknown',
    'price': product['price'] ?? 0,
    'imageUrl': product['mainImage'] != null
        ? 'http://localhost:8080/image/${product['mainImage']}'
        : 'assets/images/apple-iphone-15-plus-black-official-image.jpg',
  };

  setState(() {
    _cart.add(cartProduct);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("${cartProduct['name']} added to cart")),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CartPage(cartItems: _cart),
    ),
  );
}


  void _buyNow(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(product: product, cartItems: [],),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final imageUrl = product['mainImage'] != null
        ? 'http://localhost:8080/image/${product['mainImage']}'
        : 'assets/images/apple-iphone-15-plus-black-official-image.jpg';

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= Main Section =================
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 800;
                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ---- Product Image ----
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showImageModal = true;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32, height: 32),
                      // ---- Product Info ----
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productName'] ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Price: ৳${product['price'] ?? 0}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF57224),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Product Code: ${product['productCode'] ?? ''}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product['stock'] != null &&
                                      product['stock'] > 0
                                  ? "✅ In Stock"
                                  : "❌ Out of Stock",
                              style: TextStyle(
                                fontSize: 16,
                                color: product['stock'] != null &&
                                        product['stock'] > 0
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Sold by: ${product['sellerName'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "⭐ ${product['avgRating'] ?? 0} / 5 (${product['reviewCount'] ?? 0} reviews)",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            // ---- Buttons ----
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: 
                                  (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => _buyNow(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF57224),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🚀 Buy Now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: 
                                  (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => _addToCart(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF007BFF),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🛒 Add to Cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // ================= Description Section =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "📃 Description",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(thickness: 2, color: Color(0xFFF57224)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product['description'] ?? 'No description available.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // ================= Image Modal =================
            if (showImageModal)
              GestureDetector(
                onTap: () {
                  setState(() {
                    showImageModal = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: InteractiveViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
 */

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required Null Function(dynamic prod) onAddToCart,
    required Null Function(dynamic prod) onBuyNow,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showImageModal = false;
  final List<Map<String, dynamic>> _cart = []; // simple cart list

  // ---- Add to Cart ----
  void _addToCart(Map<String, dynamic> product) {
    final cartProduct = {
      'name': product['productName'] ?? 'Unknown',
      'price': product['price'] ?? 0,
      'imageUrl': product['mainImage'] != null
          ? 'http://localhost:8080/image/${product['mainImage']}'
          : 'assets/images/apple-iphone-15-plus-black-official-image.jpg',
      'quantity': 1,
    };

    setState(() {
      _cart.add(cartProduct);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${cartProduct['name']} added to cart")),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartPage(cartItems: _cart)),
    );
  }

  // ---- Buy Now ----
  void _buyNow(Map<String, dynamic> product) {
    final buyNowCartItem = {
      'name': product['productName'] ?? 'Unknown',
      'price': product['price'] ?? 0,
      'imageUrl': product['mainImage'] != null
          ? 'http://localhost:8080/image/${product['mainImage']}'
          : 'assets/images/apple-iphone-15-plus-black-official-image.jpg',
      'quantity': 1,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(
          product: product,
          cartItems: [buyNowCartItem], // send single product as list
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final imageUrl = product['mainImage'] != null
        ? 'http://localhost:8080/image/${product['mainImage']}'
        : 'assets/images/apple-iphone-15-plus-black-official-image.jpg';

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= Main Section =================
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 800;
                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ---- Product Image ----
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showImageModal = true;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                      'assets/images/apple-iphone-15-plus-black-official-image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32, height: 32),
                      // ---- Product Info ----
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productName'] ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Price: ৳${product['price'] ?? 0}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF57224),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Product Code: ${product['productCode'] ?? ''}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product['stock'] != null && product['stock'] > 0
                                  ? "✅ In Stock"
                                  : "❌ Out of Stock",
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    product['stock'] != null &&
                                        product['stock'] > 0
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Sold by: ${product['sellerName'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "⭐ ${product['avgRating'] ?? 0} / 5 (${product['reviewCount'] ?? 0} reviews)",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            // ---- Buttons ----
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => _buyNow(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF57224),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🚀 Buy Now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: (product['stock'] ?? 0) <= 0
                                      ? null
                                      : () => _addToCart(product),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF007BFF),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "🛒 Add to Cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // ================= Description Section =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "📃 Description",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(thickness: 2, color: Color(0xFFF57224)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product['description'] ?? 'No description available.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // ================= Image Modal =================
            if (showImageModal)
              GestureDetector(
                onTap: () {
                  setState(() {
                    showImageModal = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: InteractiveViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
