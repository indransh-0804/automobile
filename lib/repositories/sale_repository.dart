import 'package:automobile/models/sale_model.dart';

abstract class SaleRepository {
  Stream<List<SaleModel>> salesStream();
  Future<void> addSale(SaleModel sale);
}
