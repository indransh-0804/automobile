import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/providers/repository_providers.dart';

final carsProvider = StreamProvider<List<CarModel>>((ref) {
  final repository = ref.watch(carRepositoryProvider);
  return repository.carsStream();
});

final carControllerProvider = Provider<CarController>((ref) {
  return CarController(ref);
});

class CarController {
  final Ref _ref;

  CarController(this._ref);

  Future<void> addCar(CarModel car) async {
    final repository = _ref.read(carRepositoryProvider);
    await repository.addCar(car);
  }

  Future<void> updateCar(CarModel car) async {
    final repository = _ref.read(carRepositoryProvider);
    await repository.updateCar(car);
  }

  Future<void> deleteCar(String id) async {
    final repository = _ref.read(carRepositoryProvider);
    await repository.deleteCar(id);
  }
}
