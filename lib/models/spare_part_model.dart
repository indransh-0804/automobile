import 'package:cloud_firestore/cloud_firestore.dart';

class SparePartModel {
  final String id;
  final String name;
  final String partNumber;
  final String category;
  final double price;
  final int stockCount;
  final int lowStockThreshold;
  final String supplierId;
  final DateTime createdAt;

  SparePartModel({
    required this.id,
    required this.name,
    required this.partNumber,
    required this.category,
    required this.price,
    required this.stockCount,
    required this.lowStockThreshold,
    required this.supplierId,
    required this.createdAt,
  });

  factory SparePartModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SparePartModel(
      id: doc.id,
      name: data['name'] as String,
      partNumber: data['partNumber'] as String,
      category: data['category'] as String,
      price: (data['price'] as num).toDouble(),
      stockCount: data['stockCount'] as int,
      lowStockThreshold: data['lowStockThreshold'] as int,
      supplierId: data['supplierId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'partNumber': partNumber,
      'category': category,
      'price': price,
      'stockCount': stockCount,
      'lowStockThreshold': lowStockThreshold,
      'supplierId': supplierId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
