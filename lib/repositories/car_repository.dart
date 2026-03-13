import 'package:automobile/models/car_model.dart';

abstract class CarRepository {
  Stream<List<CarModel>> carsStream();
  Future<void> addCar(CarModel car);
  Future<void> updateCar(CarModel car);
  Future<void> deleteCar(String id);
}
