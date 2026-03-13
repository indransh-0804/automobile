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

  const CarModel({
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

  CarModel copyWith({
    String? id,
    String? make,
    String? model,
    int? year,
    String? color,
    String? vin,
    double? price,
    int? stockCount,
    CarStatus? status,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return CarModel(
      id: id ?? this.id,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      vin: vin ?? this.vin,
      price: price ?? this.price,
      stockCount: stockCount ?? this.stockCount,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
