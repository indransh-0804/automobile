import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel {
  final String id;
  final String purchaseId;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String employeeId;

  SaleModel({
    required this.id,
    required this.purchaseId,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.employeeId,
  });

  factory SaleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SaleModel(
      id: doc.id,
      purchaseId: data['purchaseId'] as String,
      amount: (data['amount'] as num).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      employeeId: data['employeeId'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'purchaseId': purchaseId,
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'paymentMethod': paymentMethod,
      'employeeId': employeeId,
    };
  }
}
