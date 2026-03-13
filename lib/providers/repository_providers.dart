import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/app_config.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/repositories/car_repository.dart';
import 'package:automobile/repositories/spare_part_repository.dart';
import 'package:automobile/repositories/sale_repository.dart';
import 'package:automobile/repositories/loan_repository.dart';
import 'package:automobile/repositories/purchase_repository.dart';
import 'package:automobile/repositories/test_drive_repository.dart';
import 'package:automobile/repositories/appointment_repository.dart';
import 'package:automobile/repositories/mock/mock_car_repository.dart';
import 'package:automobile/repositories/mock/mock_spare_part_repository.dart';
import 'package:automobile/repositories/mock/mock_sale_repository.dart';
import 'package:automobile/repositories/mock/mock_loan_repository.dart';
import 'package:automobile/repositories/mock/mock_purchase_repository.dart';
import 'package:automobile/repositories/mock/mock_test_drive_repository.dart';
import 'package:automobile/repositories/mock/mock_appointment_repository.dart';
import 'package:automobile/repositories/firestore/firestore_car_repository.dart';
import 'package:automobile/repositories/firestore/firestore_spare_part_repository.dart';
import 'package:automobile/repositories/firestore/firestore_sale_repository.dart';
import 'package:automobile/repositories/firestore/firestore_loan_repository.dart';
import 'package:automobile/repositories/firestore/firestore_purchase_repository.dart';
import 'package:automobile/repositories/firestore/firestore_test_drive_repository.dart';
import 'package:automobile/repositories/firestore/firestore_appointment_repository.dart';

final carRepositoryProvider = Provider<CarRepository>((ref) {
  if (useMockData) return MockCarRepository();
  return FirestoreCarRepository(ref.watch(firestoreServiceProvider));
});

final sparePartRepositoryProvider = Provider<SparePartRepository>((ref) {
  if (useMockData) return MockSparePartRepository();
  return FirestoreSparePartRepository(ref.watch(firestoreServiceProvider));
});

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  if (useMockData) return MockSaleRepository();
  return FirestoreSaleRepository(ref.watch(firestoreServiceProvider));
});

final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  if (useMockData) return MockLoanRepository();
  return FirestoreLoanRepository(ref.watch(firestoreServiceProvider));
});

final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  if (useMockData) return MockPurchaseRepository();
  return FirestorePurchaseRepository(ref.watch(firestoreServiceProvider));
});

final testDriveRepositoryProvider = Provider<TestDriveRepository>((ref) {
  if (useMockData) return MockTestDriveRepository();
  return FirestoreTestDriveRepository(ref.watch(firestoreServiceProvider));
});

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  if (useMockData) return MockAppointmentRepository();
  return FirestoreAppointmentRepository(ref.watch(firestoreServiceProvider));
});
