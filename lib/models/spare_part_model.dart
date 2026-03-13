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

  const SparePartModel({
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

  SparePartModel copyWith({
    String? id,
    String? name,
    String? partNumber,
    String? category,
    double? price,
    int? stockCount,
    int? lowStockThreshold,
    String? supplierId,
    DateTime? createdAt,
  }) {
    return SparePartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      partNumber: partNumber ?? this.partNumber,
      category: category ?? this.category,
      price: price ?? this.price,
      stockCount: stockCount ?? this.stockCount,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      supplierId: supplierId ?? this.supplierId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
