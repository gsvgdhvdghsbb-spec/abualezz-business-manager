class ProductModel {
  int? id;
  String barcode;
  String name;
  double purchasePrice;
  double sellingPrice;
  int quantity;
  int minQuantityAlert;
  String? category;
  String? imagePath;
  DateTime createdAt;

  ProductModel({
    this.id,
    required this.barcode,
    required this.name,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.quantity,
    this.minQuantityAlert = 5,
    this.category,
    this.imagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // تحويل إلى Map لحفظ البيانات بسهولة
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'minQuantityAlert': minQuantityAlert,
      'category': category,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // إنشاء كائن من Map عند استرجاع البيانات
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      barcode: map['barcode'],
      name: map['name'],
      purchasePrice: map['purchasePrice'],
      sellingPrice: map['sellingPrice'],
      quantity: map['quantity'],
      minQuantityAlert: map['minQuantityAlert'] ?? 5,
      category: map['category'],
      imagePath: map['imagePath'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
