import 'package:dryve/controllers/home_controller.dart';
import 'package:dryve/repositories/brand_repository.dart';
import 'package:dryve/repositories/car_repository.dart';
import 'package:dryve/repositories/color_repository.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandRepository>(() => BrandRepository(), fenix: true);
    Get.lazyPut<ColorRepository>(() => ColorRepository(), fenix: true);
    Get.lazyPut<CarRepository>(() => CarRepository(), fenix: true);

    Get.put(HomeController(Get.find(), Get.find(), Get.find()));
  }
}
