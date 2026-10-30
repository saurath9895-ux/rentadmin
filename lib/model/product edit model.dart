class DetailEdit {
  final String productId;
  final String productName;
  final String category;
  final double rentPrice;
  final double securityDeposit;
  final String startDate;
  final String endDate;
  final String pickupLocation;
  final String description;
  final List<String> features;
  final String? productImage;

  DetailEdit({
    required this.productId,
    required this.productName,
    required this.category,
    required this.rentPrice,
    required this.securityDeposit,
    required this.startDate,
    required this.endDate,
    required this.pickupLocation,
    required this.description,
    required this.features,
    this.productImage,
  });

  factory DetailEdit.fromMap(Map<String, dynamic> map, String id) {
    var rawFeatures = map["features"];
    List<String> parsedFeatures = [];
    if (rawFeatures is List) {
      parsedFeatures = rawFeatures.map((e) => e.toString()).toList();
    }

    return DetailEdit(
      productId: id,
      productName: map["product"] ?? map["name"] ?? "",
      category: map["category"] ?? "",
      rentPrice: double.tryParse(map["rent"]?.toString().replaceAll(RegExp(r'[^0-9.]'), '') ?? "0") ?? 0.0,
      securityDeposit: double.tryParse(map["security"]?.toString().replaceAll(RegExp(r'[^0-9.]'), '') ?? "0") ?? 0.0,
      startDate: map["startDate"] ?? "",
      endDate: map["endDate"] ?? "",
      pickupLocation: map["pickupLocation"] ?? map["location"] ?? "",
      description: map["description"] ?? "",
      features: parsedFeatures,
      productImage: map["image"] ?? map["productImage"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "product": productName,
      "category": category,
      "rent": rentPrice,
      "security": securityDeposit,
      "startDate": startDate,
      "endDate": endDate,
      "pickupLocation": pickupLocation,
      "description": description,
      "features": features,
      "image": productImage,
    };
  }
}