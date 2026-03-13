import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/loan_model.dart';

final loansProvider = StreamProvider<List<LoanModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.loansStream();
});

final loanControllerProvider = Provider<LoanController>((ref) {
  return LoanController(ref);
});

class LoanController {
  final Ref _ref;

  LoanController(this._ref);

  Future<void> addLoan(LoanModel loan) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addLoan(loan);
  }

  Future<void> updateLoanStatus(String id, LoanStatus status) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.updateLoanStatus(id, status);
  }
}
