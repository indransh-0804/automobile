import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final loansProvider = StreamProvider<List<LoanModel>>((ref) {
  final repository = ref.watch(loanRepositoryProvider);
  return repository.loansStream();
});

final loanControllerProvider = Provider<LoanController>((ref) {
  return LoanController(ref);
});

class LoanController {
  final Ref _ref;

  LoanController(this._ref);

  Future<void> addLoan(LoanModel loan) async {
    final repository = _ref.read(loanRepositoryProvider);
    await repository.addLoan(loan);
  }

  Future<void> updateLoanStatus(String id, LoanStatus status) async {
    final repository = _ref.read(loanRepositoryProvider);
    await repository.updateLoanStatus(id, status);
  }
}
