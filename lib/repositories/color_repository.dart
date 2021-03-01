import 'package:dryve/models/color_model.dart';
import 'package:get/get_connect/connect.dart';

class ColorRepository extends GetConnect {
  Future<List<ColorModel>> getAllColors() async {
    final response = await get('https://run.mocky.io/v3/ac466e17-58a4-432b-8647-7a2e4c4074e2', decoder: (body) {
      if (body is List) {
        return body.map<ColorModel>((resp) => ColorModel.fromJson(resp)).toList();
      }
      return null;
    });
    if (response.hasError) {
      throw Exception('Erro ao buscar as cores');
    }
    return response.body;
  }
}
