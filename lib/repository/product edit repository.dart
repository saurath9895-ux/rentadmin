import '../model/product edit model.dart';
import '../services/product edit service.dart';

class DetailEditRepository {
  final DetailEditService _service = DetailEditService();

  Future<bool> updateProduct(DetailEdit model) async {
    return await _service.updateProductData(model);
  }
}