import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  final String id;
  final String customerId;
  final String customerName;
  final String carId;
  final String carName;
  final double salePrice;
  final String paymentMethod;
  final DateTime date;
  final String employeeId;
  final String notes;

  PurchaseModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.carId,
    required this.carName,
    required this.salePrice,
    required this.paymentMethod,
    required this.date,
    required this.employeeId,
    required this.notes,
  });

  factory PurchaseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PurchaseModel(
      id: doc.id,
      customerId: data['customerId'] as String,
      customerName: data['customerName'] as String,
      carId: data['carId'] as String,
      carName: data['carName'] as String,
      salePrice: (data['salePrice'] as num).toDouble(),
      paymentMethod: data['paymentMethod'] as String,
      date: (data['date'] as Timestamp).toDate(),
      employeeId: data['employeeId'] as String,
      notes: data['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'carId': carId,
      'carName': carName,
      'salePrice': salePrice,
      'paymentMethod': paymentMethod,
      'date': Timestamp.fromDate(date),
      'employeeId': employeeId,
      'notes': notes,
    };
  }
}
