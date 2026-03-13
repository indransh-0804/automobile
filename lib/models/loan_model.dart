import 'package:cloud_firestore/cloud_firestore.dart';

enum LoanStatus { active, paid, defaulted }

class LoanModel {
  final String id;
  final String customerId;
  final String customerName;
  final String carId;
  final String carName;
  final double principal;
  final double interestRate;
  final int termMonths;
  final double monthlyPayment;
  final DateTime startDate;
  final LoanStatus status;

  LoanModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.carId,
    required this.carName,
    required this.principal,
    required this.interestRate,
    required this.termMonths,
    required this.monthlyPayment,
    required this.startDate,
    required this.status,
  });

  factory LoanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LoanModel(
      id: doc.id,
      customerId: data['customerId'] as String,
      customerName: data['customerName'] as String,
      carId: data['carId'] as String,
      carName: data['carName'] as String,
      principal: (data['principal'] as num).toDouble(),
      interestRate: (data['interestRate'] as num).toDouble(),
      termMonths: data['termMonths'] as int,
      monthlyPayment: (data['monthlyPayment'] as num).toDouble(),
      startDate: (data['startDate'] as Timestamp).toDate(),
      status: LoanStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => LoanStatus.active,
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'carId': carId,
      'carName': carName,
      'principal': principal,
      'interestRate': interestRate,
      'termMonths': termMonths,
      'monthlyPayment': monthlyPayment,
      'startDate': Timestamp.fromDate(startDate),
      'status': status.name,
    };
  }
}
