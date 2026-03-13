import 'dart:async';

import 'package:automobile/models/car_model.dart';
import 'package:automobile/repositories/car_repository.dart';
import 'package:automobile/repositories/mock/sample_data.dart';

class MockCarRepository implements CarRepository {
  final List<CarModel> _cars = List.from(SampleData.cars);
  late final StreamController<List<CarModel>> _controller;

  MockCarRepository() {
    _controller = StreamController<List<CarModel>>.broadcast(
      onListen: () => _emit(),
    );
  }

  void _emit() {
    _controller.add(List.unmodifiable(_cars));
  }

  @override
  Stream<List<CarModel>> carsStream() => _controller.stream;

  @override
  Future<void> addCar(CarModel car) async {
    _cars.insert(0, car);
    _emit();
  }

  @override
  Future<void> updateCar(CarModel car) async {
    final index = _cars.indexWhere((c) => c.id == car.id);
    if (index != -1) {
      _cars[index] = car;
      _emit();
    }
  }

  @override
  Future<void> deleteCar(String id) async {
    _cars.removeWhere((c) => c.id == id);
    _emit();
  }
}
