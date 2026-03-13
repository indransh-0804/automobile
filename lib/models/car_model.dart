import 'package:cloud_firestore/cloud_firestore.dart';

enum CarStatus { available, sold, reserved }

class CarModel {
  final String id;
  final String make;
  final String model;
  final int year;
  final String color;
  final String vin;
  final double price;
  final int stockCount;
  final CarStatus status;
  final String imageUrl;
  final DateTime createdAt;

  CarModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.vin,
    required this.price,
    required this.stockCount,
    required this.status,
    required this.imageUrl,
    required this.createdAt,
  });

  factory CarModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CarModel(
      id: doc.id,
      make: data['make'] as String,
      model: data['model'] as String,
      year: data['year'] as int,
      color: data['color'] as String,
      vin: data['vin'] as String,
      price: (data['price'] as num).toDouble(),
      stockCount: data['stockCount'] as int,
      status: CarStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => CarStatus.available,
      ),
      imageUrl: data['imageUrl'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'vin': vin,
      'price': price,
      'stockCount': stockCount,
      'status': status.name,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
