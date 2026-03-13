import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/data/mock_data.dart';

final carsProvider = Provider<List<CarModel>>((ref) {
  return MockData.cars;
});
