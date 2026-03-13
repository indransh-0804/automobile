import 'package:automobile/models/loan_model.dart';

abstract class LoanRepository {
  Stream<List<LoanModel>> loansStream();
  Future<void> addLoan(LoanModel loan);
  Future<void> updateLoanStatus(String id, LoanStatus status);
}
