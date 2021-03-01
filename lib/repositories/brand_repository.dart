import 'package:dryve/models/brand_model.dart';
import 'package:get/get_connect/connect.dart';

class BrandRepository extends GetConnect {
  Future<List<BrandModel>> getAllBrands() async {
    final response = await get('https://run.mocky.io/v3/4f858a89-17b2-4e9c-82e0-5cdce6e90d29', decoder: (body) {
      if (body is List) {
        return body.map<BrandModel>((resp) => BrandModel.fromJson(resp)).toList();
      }
      return null;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar as brands');
    }
    return response.body;
  }
}
