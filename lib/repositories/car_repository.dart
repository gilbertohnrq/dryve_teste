import 'package:dryve/models/car_model.dart';
import 'package:get/get_connect/connect.dart';

class CarRepository extends GetConnect {
  Future<List<CarModel>> getAllCars() async {
    try {
      final response = await get('https://run.mocky.io/v3/e2fe4deb-f65d-45e2-b548-39c17f08e637', decoder: (body) {
        return body.map<CarModel>((resp) => CarModel.fromJson(resp)).toList();
      });
      return response.body;
    } catch (e) {
      print(e);
      throw Exception('Erro ao buscar os carros');
    }
  }
}
