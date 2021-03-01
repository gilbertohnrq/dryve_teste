import 'package:dryve/models/car_model.dart';
import 'package:dryve/utils/fluttertoast_util.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';

class CarRepository extends GetConnect {
  Future<List<CarModel>> getAllCars() async {
    try {
      final response = await get('https://run.mocky.io/v3/e2fe4deb-f65d-45e2-b548-39c17f08e637', decoder: (body) {
        return body.map<CarModel>((resp) => CarModel.fromJson(resp)).toList();
      });
      GetStorage().write('carList', response.body);
      return _getAllFavoritedCars(response.body);
    } catch (e) {
      List storedCarList = await GetStorage().read('carList');
      List<CarModel> auxList = storedCarList.map<CarModel>((car) => CarModel.fromJson(car)).toList();
      FluttertoastUtil.showToast(msg: "Lista recuperada do storage local");
      return  _getAllFavoritedCars(auxList);
    }
  }

  saveFavoritedCars(CarModel car) {
    if (car.favorited == true) {
      GetStorage().write('favoritedCar-${car.id}', car.id);
    } else {
      GetStorage().remove('favoritedCar-${car.id}');
    }
  }

  List<CarModel> _getAllFavoritedCars(List<CarModel> carList) {
    List<String> ids = [];
    carList.forEach((car) {
     ids.add(GetStorage().read('favoritedCar-${car.id}'));
    });
    ids.forEach((id){
      carList.forEach((car){
        if(id == car.id){
          car.favorited = true;
        }
      });
    });
    return carList;
  }
}
