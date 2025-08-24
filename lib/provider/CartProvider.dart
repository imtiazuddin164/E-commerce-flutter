// import 'package:flutter/foundation.dart';
// import 'cart_item.dart';

// class CartProvider with ChangeNotifier {
//   final Map<String, CartItem> _items = {};

//   Map<String, CartItem> get items => {..._items};

//   int get itemCount => _items.length;

//   double get totalAmount {
//     double total = 0.0;
//     _items.forEach((key, cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });
//     return total;
//   }

//   void addItem(String productId, String name, double price) {
//     if (_items.containsKey(productId)) {
//       _items.update(
//         productId,
//         (existingItem) => CartItem(
//           id: existingItem.id,
//           name: existingItem.name,
//           price: existingItem.price,
//           quantity: existingItem.quantity + 1,
//         ),
//       );
//     } else {
//       _items.putIfAbsent(
//         productId,
//         () => CartItem(
//           id: DateTime.now().toString(),
//           name: name,
//           price: price,
//         ),
//       );
//     }
//     notifyListeners();
//   }

//   void removeItem(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }

//   void clear() {
//     _items.clear();
//     notifyListeners();
//   }
// }
