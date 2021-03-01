import 'dart:collection';

import 'package:dryve/models/brand_model.dart';
import 'package:dryve/models/car_model.dart';
import 'package:dryve/models/color_model.dart';
import 'package:dryve/repositories/brand_repository.dart';
import 'package:dryve/repositories/car_repository.dart';
import 'package:dryve/repositories/color_repository.dart';
import 'package:dryve/utils/fluttertoast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final BrandRepository _brandRepository;
  final ColorRepository _colorRepository;
  final CarRepository _carRepository;

  HomeController(this._brandRepository, this._colorRepository, this._carRepository);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getBrands();
    getCars();
    getColors();
  }

  final _carList = new List<CarModel>().obs;
  final _brandList = new List<BrandModel>().obs;
  final _colorList = new List<ColorModel>().obs;
  final _carListFiltered = new List<CarModel>().obs;
  final _brandListFiltered = new List<BrandModel>().obs;
  final _filterApplied = false.obs;
  final _nameFilterApplied = false.obs;
  final _counter = 0.obs;

  TextEditingController searchByName = new TextEditingController();
  List<ColorModel> get colorList => _colorList;
  List<CarModel> get carListFiltered => _carList;
  List<BrandModel> get brandListFiltered => _brandList;
  List<BrandModel> get brandList {
    if (_nameFilterApplied.value == true) {
      return _brandListFiltered;
    } else {
      return _brandList;
    }
  }

  List<CarModel> get carList {
    if (_filterApplied.value == true) {
      return _carListFiltered;
    } else {
      return _carList;
    }
  }

  int get counter => _counter.value;

  Future<void> getBrands() async {
    final data = await _brandRepository.getAllBrands();
    _brandList.assignAll(data);
  }

  Future<void> getCars() async {
    final data = await _carRepository.getAllCars();
    _carList.assignAll(data);
  }

  Future<void> getColors() async {
    final data = await _colorRepository.getAllColors();
    _colorList.assignAll(data);
  }

  void filterByName(String value) {
    if (searchByName.text == '') {
      _nameFilterApplied.value = false;
    } else {
      _nameFilterApplied.value = true;
      _brandList.forEach((brand) {
        _brandListFiltered.assignAll(_brandList.where((brand) => brand.name.toLowerCase().contains(searchByName.text.toLowerCase())).toList());
      });
    }
  }

  void applyFilter() {
    _filterApplied.value = false;
    _carListFiltered.clear();
    _counter.value = 0;
    _colorList.forEach((color) {
      if (color.checked) {
        _counter.value++;
        _filterApplied.value = true;
        _carListFiltered.addAll(_carList.where((car) => car.colorId == int.parse(color.colorId)).toList());
      }
    });
    _brandList.forEach((brand) {
      if (brand.checked) {
        _counter.value++;
        _filterApplied.value = true;
        _carListFiltered.addAll(_carList.where((car) => car.brandId == int.parse(brand.brandId)).toList());
      }
    });
    _carListFiltered.assignAll(LinkedHashSet<CarModel>.from(_carListFiltered).toList());
    Get.back();
  }

  void clearFilter() {
    _counter.value = 0;
    _carListFiltered.clear();
    _filterApplied.value = false;

    _brandList.forEach((brand) {
      brand.checked = false;
    });
    _colorList.forEach((color) {
      color.checked = false;
    });
    Get.back();
    FluttertoastUtil.showToast(msg: "Filtro removido");
  }

  void setIsCarFavorited(Rx<CarModel> car) {
    car.update((val) {
      val.favorited = !val.favorited;
    });
  }

  void setIsColorChecked(Rx<ColorModel> color) {
    color.update((val) {
      val.checked = !val.checked;
    });
  }

  void setIsBrandChecked(Rx<BrandModel> brand) {
    brand.update((val) {
      val.checked = !val.checked;
    });
  }
}
