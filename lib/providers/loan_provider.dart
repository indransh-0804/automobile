import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/data/mock_data.dart';

final loansProvider = Provider<List<LoanModel>>((ref) {
  return MockData.loans;
});

final activeLoansCountProvider = Provider<int>((ref) {
  final loans = ref.watch(loansProvider);
  return loans.where((loan) => loan.status == LoanStatus.active).length;
});
