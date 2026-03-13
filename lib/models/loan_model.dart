enum LoanStatus { active, paid, defaulted }

class LoanModel {
  final String id;
  final String customerName;
  final String carName;
  final double principal;
  final double interestRate;
  final int termMonths;
  final double monthlyPayment;
  final DateTime startDate;
  final LoanStatus status;

  const LoanModel({
    required this.id,
    required this.customerName,
    required this.carName,
    required this.principal,
    required this.interestRate,
    required this.termMonths,
    required this.monthlyPayment,
    required this.startDate,
    required this.status,
  });

  LoanModel copyWith({
    String? id,
    String? customerName,
    String? carName,
    double? principal,
    double? interestRate,
    int? termMonths,
    double? monthlyPayment,
    DateTime? startDate,
    LoanStatus? status,
  }) {
    return LoanModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      carName: carName ?? this.carName,
      principal: principal ?? this.principal,
      interestRate: interestRate ?? this.interestRate,
      termMonths: termMonths ?? this.termMonths,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
    );
  }
}
