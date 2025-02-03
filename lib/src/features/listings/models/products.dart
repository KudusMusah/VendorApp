class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String sellerId;
  final String shopId;
  final int stockQuantity;
  final String createdAt;
  final String updatedAt;
  // final int? qty;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.sellerId,
    required this.shopId,
    required this.stockQuantity,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    String? sellerId,
    String? shopId,
    int? stockQuantity,
    String? createdAt,
    String? updatedAt,
    int? qty,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      sellerId: sellerId ?? this.sellerId,
      shopId: shopId ?? this.shopId,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'sellerId': sellerId,
      'shopId': shopId,
      'stockQuantity': stockQuantity,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
      sellerId: map['sellerId'] as String,
      shopId: map['shopId'] as String,
      stockQuantity: map['stockQuantity'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, imageUrl: $imageUrl, sellerId: $sellerId, shopId: $shopId, stockQuantity: $stockQuantity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.sellerId == sellerId &&
        other.shopId == shopId &&
        other.stockQuantity == stockQuantity &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        sellerId.hashCode ^
        shopId.hashCode ^
        stockQuantity.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
