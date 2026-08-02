import 'package:isar/isar.dart';

part 'product_model.g.dart';

@collection
class ProductModel {
  Id id = Isar.autoIncrement; // معرف تلقائي

  @Index(unique: true, replace: true)
  late String barcode;       // الباركود (فريد)

  late String name;          // اسم الصنف
  late double purchasePrice; // سعر الشراء
  late double sellingPrice;  // سعر البيع
  late int quantity;         // الكمية المتوفرة
  late int minQuantityAlert; // حد التنبيه لنفاد المخزون
  
  String? category;          // التصنيف (قطع غيار، إلكترونيات، إلخ)
  String? imagePath;         // مسار صورة المنتج

  DateTime createdAt = DateTime.now();
}

