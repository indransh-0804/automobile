import 'package:automobile/core/services/firestore_service.dart';
import 'package:automobile/models/sale_model.dart';
import 'package:automobile/repositories/sale_repository.dart';

class FirestoreSaleRepository implements SaleRepository {
  final FirestoreService _service;

  FirestoreSaleRepository(this._service);

  @override
  Stream<List<SaleModel>> salesStream() => _service.salesStream();

  @override
  Future<void> addSale(SaleModel sale) => _service.addSale(sale);
}
