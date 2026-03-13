import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/repositories/loan_repository.dart';

class FirestoreLoanRepository implements LoanRepository {
  final FirestoreService _service;

  FirestoreLoanRepository(this._service);

  @override
  Stream<List<LoanModel>> loansStream() => _service.loansStream();

  @override
  Future<void> addLoan(LoanModel loan) => _service.addLoan(loan);

  @override
  Future<void> updateLoanStatus(String id, LoanStatus status) =>
      _service.updateLoanStatus(id, status);
}
