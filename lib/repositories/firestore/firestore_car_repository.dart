import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/repositories/car_repository.dart';

class FirestoreCarRepository implements CarRepository {
  final FirestoreService _service;

  FirestoreCarRepository(this._service);

  @override
  Stream<List<CarModel>> carsStream() => _service.carsStream();

  @override
  Future<void> addCar(CarModel car) => _service.addCar(car);

  @override
  Future<void> updateCar(CarModel car) => _service.updateCar(car);

  @override
  Future<void> deleteCar(String id) => _service.deleteCar(id);
}
