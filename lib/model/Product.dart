
class Product {
  final int? id;
  final String? productCode;
  final String? productName;
  final String? description;
  final int? categoryId;
  final String? categoryName;
  final int? subcategoryId;
  final String? subcategoryName;
  final int? sellerId;
  final double? price;
  final int? stock;
  final String? mainImage;


    Product({
    this.id,
    this.productCode,
    this.productName,
    this.description,
    this.categoryId,
    this.categoryName,
    this.subcategoryId,
    this.subcategoryName,
    this.sellerId,
    this.price,
    this.stock,
    this.mainImage,
  });


  factory Product.fromJson(Map<String, dynamic> json) {
      const baseUrl = "http://localhost:8080/image/";
    return Product(
      id: json['id'],
      productCode: json['productCode'],
      productName: json['productName'],
      description: json['description'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      subcategoryId: json['subcategoryId'],
      subcategoryName: json['subcategoryName'],
      sellerId: json['sellerId'],
      price: (json['price'] as num?)?.toDouble(),
      stock: json['stock'],
      mainImage: json['mainImage'] != null ? baseUrl + json['mainImage'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'productName': productName,
      'description': description,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'subcategoryId': subcategoryId,
      'subcategoryName': subcategoryName,
      'sellerId': sellerId,
      'price': price,
      'stock': stock,
      'mainImage': mainImage,
    };
  }
}

