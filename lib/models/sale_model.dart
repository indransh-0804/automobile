class SaleModel {
  final String id;
  final String purchaseId;
  final String carName;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String employeeId;

  const SaleModel({
    required this.id,
    required this.purchaseId,
    required this.carName,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.employeeId,
  });

  SaleModel copyWith({
    String? id,
    String? purchaseId,
    String? carName,
    double? amount,
    DateTime? date,
    String? paymentMethod,
    String? employeeId,
  }) {
    return SaleModel(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      carName: carName ?? this.carName,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      employeeId: employeeId ?? this.employeeId,
    );
  }
}
