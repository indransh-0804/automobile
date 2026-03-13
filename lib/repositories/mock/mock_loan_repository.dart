import 'dart:async';

import 'package:automobile/models/loan_model.dart';
import 'package:automobile/repositories/loan_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockLoanRepository implements LoanRepository {
  final List<LoanModel> _loans = List.from(SampleData.loans);
  late final StreamController<List<LoanModel>> _controller;

  MockLoanRepository() {
    _controller = StreamController<List<LoanModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_loans));
  }

  @override
  Stream<List<LoanModel>> loansStream() => _controller.stream;

  @override
  Future<void> addLoan(LoanModel loan) async {
    _loans.insert(0, loan);
    _emit();
  }

  @override
  Future<void> updateLoanStatus(String id, LoanStatus status) async {
    final index = _loans.indexWhere((l) => l.id == id);
    if (index != -1) {
      final loan = _loans[index];
      _loans[index] = LoanModel(
        id: loan.id,
        customerId: loan.customerId,
        customerName: loan.customerName,
        carId: loan.carId,
        carName: loan.carName,
        principal: loan.principal,
        interestRate: loan.interestRate,
        termMonths: loan.termMonths,
        monthlyPayment: loan.monthlyPayment,
        startDate: loan.startDate,
        status: status,
      );
      _emit();
    }
  }
}
