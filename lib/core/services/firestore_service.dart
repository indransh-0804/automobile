import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/constants/firestore_constants.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/models/spare_part_model.dart';
import 'package:automobile/models/purchase_model.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/models/test_drive_model.dart';
import 'package:automobile/models/service_appointment_model.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(FirebaseFirestore.instance);
});

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Stream<List<CarModel>> carsStream() {
    return _firestore
        .collection(FirestoreConstants.carsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CarModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addCar(CarModel car) {
    return _firestore
        .collection(FirestoreConstants.carsCollection)
        .doc(car.id)
        .set(car.toFirestore());
  }

  Future<void> updateCar(CarModel car) {
    return _firestore
        .collection(FirestoreConstants.carsCollection)
        .doc(car.id)
        .update(car.toFirestore());
  }

  Future<void> deleteCar(String id) {
    return _firestore
        .collection(FirestoreConstants.carsCollection)
        .doc(id)
        .delete();
  }

  Stream<List<SparePartModel>> sparePartsStream() {
    return _firestore
        .collection(FirestoreConstants.sparePartsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SparePartModel.fromFirestore(doc))
            .toList());
  }

  Stream<List<SparePartModel>> lowStockPartsStream() {
    return sparePartsStream().map((parts) =>
        parts.where((p) => p.stockCount <= p.lowStockThreshold).toList());
  }

  Future<void> addSparePart(SparePartModel part) {
    return _firestore
        .collection(FirestoreConstants.sparePartsCollection)
        .doc(part.id)
        .set(part.toFirestore());
  }

  Future<void> updateSparePart(SparePartModel part) {
    return _firestore
        .collection(FirestoreConstants.sparePartsCollection)
        .doc(part.id)
        .update(part.toFirestore());
  }

  Future<void> deleteSparePart(String id) {
    return _firestore
        .collection(FirestoreConstants.sparePartsCollection)
        .doc(id)
        .delete();
  }

  Stream<List<PurchaseModel>> purchasesStream() {
    return _firestore
        .collection(FirestoreConstants.purchasesCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PurchaseModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addPurchase(PurchaseModel purchase) {
    return _firestore
        .collection(FirestoreConstants.purchasesCollection)
        .doc(purchase.id)
        .set(purchase.toFirestore());
  }

  Stream<List<LoanModel>> loansStream() {
    return _firestore
        .collection(FirestoreConstants.loansCollection)
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addLoan(LoanModel loan) {
    return _firestore
        .collection(FirestoreConstants.loansCollection)
        .doc(loan.id)
        .set(loan.toFirestore());
  }

  Future<void> updateLoanStatus(String id, LoanStatus status) {
    return _firestore
        .collection(FirestoreConstants.loansCollection)
        .doc(id)
        .update({'status': status.name});
  }

  Stream<List<SaleModel>> salesStream() {
    return _firestore
        .collection(FirestoreConstants.salesCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SaleModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addSale(SaleModel sale) {
    return _firestore
        .collection(FirestoreConstants.salesCollection)
        .doc(sale.id)
        .set(sale.toFirestore());
  }

  Stream<List<TestDriveModel>> testDrivesStream() {
    return _firestore
        .collection(FirestoreConstants.testDrivesCollection)
        .orderBy('scheduledAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TestDriveModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addTestDrive(TestDriveModel testDrive) {
    return _firestore
        .collection(FirestoreConstants.testDrivesCollection)
        .doc(testDrive.id)
        .set(testDrive.toFirestore());
  }

  Future<void> updateTestDriveStatus(String id, TestDriveStatus status) {
    return _firestore
        .collection(FirestoreConstants.testDrivesCollection)
        .doc(id)
        .update({'status': status.name});
  }

  Stream<List<ServiceAppointmentModel>> appointmentsStream() {
    return _firestore
        .collection(FirestoreConstants.serviceAppointmentsCollection)
        .orderBy('scheduledAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceAppointmentModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addAppointment(ServiceAppointmentModel appointment) {
    return _firestore
        .collection(FirestoreConstants.serviceAppointmentsCollection)
        .doc(appointment.id)
        .set(appointment.toFirestore());
  }

  Future<void> updateAppointmentStatus(String id, AppointmentStatus status) {
    return _firestore
        .collection(FirestoreConstants.serviceAppointmentsCollection)
        .doc(id)
        .update({'status': status.name});
  }
}
