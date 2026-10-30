class ProductModel {
  final String id;
  final String sellerId;
  final String name;
  final String category;
  final double price;
  final double securityDeposit;
  final String description;
  final String status;
  final String? image;

  ProductModel({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.category,
    required this.price,
    required this.securityDeposit,
    required this.description,
    required this.status,
    this.image,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      sellerId: map['sellerId'] ?? '',
      name: map['product'] ?? map['name'] ?? '',
      category: map['category'] ?? '',
      price: (map['rent'] ?? map['price'] ?? 0).toDouble(),
      securityDeposit: (map['security'] ?? map['securityDeposit'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      status: map['status'] ?? 'Pending',
      image: map['image'] ?? map['productImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sellerId': sellerId,
      'product': name,
      'category': category,
      'rent': price,
      'security': securityDeposit,
      'description': description,
      'status': status,
      'image': image,
    };
  }
}