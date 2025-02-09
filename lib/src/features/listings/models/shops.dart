class Shop {
  final String id;
  final String name;
  final String description;
  final String sellerId;
  final String createdAt;
  final String updatedAt;
  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.sellerId,
    required this.createdAt,
    required this.updatedAt,
  });

  Shop copyWith({
    String? id,
    String? name,
    String? description,
    String? sellerId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sellerId: sellerId ?? this.sellerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'sellerId': sellerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Shop.fromJson(Map<String, dynamic> map) {
    return Shop(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      sellerId: map['sellerId'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}
