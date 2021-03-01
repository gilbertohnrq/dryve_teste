import 'package:dryve/controllers/home_controller.dart';
import 'package:dryve/models/brand_model.dart';
import 'package:dryve/models/color_model.dart';
import 'package:dryve/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
    return FractionallySizedBox(
      heightFactor: 0.72,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  margin: EdgeInsets.only(left: 10),
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    onPressed: () => Get.back(),
                    child: Image.asset(
                      'assets/images/chevron_down.png',
                      height: 24,
                    ),
                  ),
                ),
                Text(
                  "Filtrar",
                  style: TextStyle(
                    color: ColorUtil.DARK_BLUE,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(width: 50),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Marca",
                            style: TextStyle(
                              color: ColorUtil.DARK_BLUE,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 25,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      child: TextField(
                        onChanged: controller.filterByName,
                        controller: controller.searchByName,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            color: ColorUtil.SECONDARY_GREY,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 10,
                            left: 15,
                          ),
                          border: OutlineInputBorder(),
                          hintText: "Buscar por nome...",
                          hintStyle: TextStyle(
                            color: ColorUtil.DARK_GREY,
                          ),
                        ),
                      ),
                    ),
                    Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.brandList.length,
                          itemBuilder: (context, index) {
                            final brand = controller.brandList[index].obs;
                            return Padding(
                              padding: EdgeInsets.only(
                                left: Get.size.width * 0.020,
                                right: Get.size.width * 0.020,
                              ),
                              child: Obx(
                                () => CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (_) {
                                    controller.setIsBrandChecked(brand);
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: brand.value.checked,
                                  title: Row(
                                    children: [
                                      _returnLogoByBrand(brand.value),
                                      SizedBox(width: 20),
                                      Text(
                                        capitalize(brand.value.name),
                                        style: TextStyle(
                                          color: ColorUtil.DARK_GREY,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                    SizedBox(height: 30),
                    Divider(
                      thickness: 1,
                      indent: Get.size.width * 0.0483,
                      endIndent: Get.size.width * 0.0483,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        left: Get.size.width * 0.0483,
                        right: Get.size.width * 0.0483,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Cor",
                            style: TextStyle(
                              color: ColorUtil.DARK_BLUE,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    GridView.count(
                      padding: EdgeInsets.only(
                        left: Get.size.width * 0.0483,
                        right: Get.size.width * 0.0483,
                      ),
                      childAspectRatio: 3.5,
                      crossAxisSpacing: Get.size.width * 0.100,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: List.generate(
                        controller.colorList.length,
                        (index) {
                          final color = controller.colorList[index].obs;
                          return Obx(() => FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => controller.setIsColorChecked(color),
                                child: Row(
                                  children: [
                                    _buildColorContainer(color),
                                    SizedBox(width: 8),
                                    Text(
                                      color.value.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorUtil.DARK_GREY,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    SizedBox(height: 33),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.size.width * 0.0483,
                        right: Get.size.width * 0.0483,
                        bottom: 29,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton(
                            onPressed: () => controller.clearFilter(),
                            buttonColor: Colors.white,
                            buttonText: "Limpar",
                            textColor: ColorUtil.BLUE,
                            borderColor: ColorUtil.BORDER_COLOR,
                          ),
                          _buildButton(
                            onPressed: () => controller.applyFilter(),
                            buttonColor: ColorUtil.BLUE,
                            buttonText: "Aplicar",
                            textColor: Colors.white,
                            borderColor: ColorUtil.BLUE,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildColorContainer(Rx<ColorModel> color) {
    if (color.value.checked) {
      return Stack(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _returnColorById(color.value),
              border: Border.all(
                color: ColorUtil.BLUE,
                width: 2,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Icon(
              Icons.check,
              color: ColorUtil.BLUE,
              size: 20,
            ),
          ),
        ],
      );
    } else {
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _returnColorById(color.value),
          border: Border.all(
            color: ColorUtil.LIGHT_GREY,
          ),
        ),
      );
    }
  }

  _buildButton({
    Function onPressed,
    String buttonText,
    Color buttonColor,
    Color textColor,
    Color borderColor,
  }) {
    return Container(
      height: 56,
      width: Get.size.width * 0.411,
      child: FlatButton(
        onPressed: onPressed,
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: borderColor),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _returnLogoByBrand(BrandModel brand) {
    String id = brand.brandId;
    if (id == '1') {
      return Image.asset(
        'assets/images/logo_audi.png',
        height: 50,
        width: 50,
      );
    }
    if (id == '2') {
      return Image.asset(
        'assets/images/logo_chevrolet.jpg',
        height: 50,
        width: 50,
      );
    }
    if (id == '3') {
      return Image.asset(
        'assets/images/logo_hyundai.png',
        height: 50,
        width: 50,
      );
    }
  }

  _returnColorById(ColorModel color) {
    String id = color.colorId;
    if (id == '1') {
      return Colors.white;
    }
    if (id == '2') {
      return ColorUtil.GREY;
    }
    if (id == '3') {
      return Colors.black;
    }
    if (id == '4') {
      return ColorUtil.RED;
    }
  }
}
