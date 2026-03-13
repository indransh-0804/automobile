import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/car_model.dart';

final carsProvider = StreamProvider<List<CarModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.carsStream();
});

final carControllerProvider = Provider<CarController>((ref) {
  return CarController(ref);
});

class CarController {
  final Ref _ref;

  CarController(this._ref);

  Future<void> addCar(CarModel car) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.addCar(car);
  }

  Future<void> updateCar(CarModel car) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.updateCar(car);
  }

  Future<void> deleteCar(String id) async {
    final service = _ref.read(firestoreServiceProvider);
    await service.deleteCar(id);
  }
}
