
import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce/model/Product.dart';
import 'package:flutter_ecommerce/service/ProductService.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _product = [];

  List<Product> get product => _product;

  Future<void> fetchProducts() async {
    try {
      _product = await _productService.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _productService.createProduct(product);
      _product.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final updateProduct = await _productService.updateProduct(product);
      final index = _product.indexWhere((t) => t.id == updateProduct.id);
      if (index != -1) {
        _product[index] = updateProduct;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _productService.deleteProduct(id);
      _product.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
