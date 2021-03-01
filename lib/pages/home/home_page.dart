import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dryve/controllers/home_controller.dart';
import 'package:dryve/pages/home/widgets/filter_bottomsheet.dart';
import 'package:dryve/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/volkswagen.png',
              height: 50,
              width: 50,
            ),
            SizedBox(width: 10),
            Text(
              'VW Seminovos',
              style: TextStyle(
                color: ColorUtil.TEXT_PRIMARY,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: controller.counter != 0
                      ? Badge(
                          badgeColor: ColorUtil.BLUE,
                          badgeContent: Text(
                            controller.counter.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/filter_icon.png',
                            height: 24,
                            width: 24,
                          ),
                        )
                      : Image.asset(
                          'assets/images/filter_icon.png',
                          height: 24,
                          width: 24,
                        ),
                  onPressed: () {
                    Get.bottomSheet(
                      FilterBottomSheet(),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await controller.getCars(true);
          },
          child: controller.carList.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        splashRadius: 25,
                        icon: Icon(
                          Icons.refresh,
                          size: 30,
                          color: ColorUtil.TEXT_PRIMARY,
                        ),
                        onPressed: () async => await controller.removeFilterAndRefresh(true),
                      ),
                      Text(
                        "Nenhum resultado encontrado :(",
                        style: TextStyle(
                          color: ColorUtil.TEXT_PRIMARY,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.count(
                  physics: BouncingScrollPhysics(),
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    left: Get.size.width * 0.0483,
                    right: Get.size.width * 0.0483,
                    top: 42,
                  ),
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  children: List.generate(
                    controller.carList.length,
                    (index) {
                      final car = controller.carList[index].obs;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: car.value.imageUrl,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: FlatButton(
                                      splashColor: Colors.white.withOpacity(0.5),
                                      onPressed: () {
                                        controller.setIsCarFavorited(car);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Obx(
                                        () => Image.asset(
                                          car.value.favorited ? 'assets/images/favorite_icon_filled.png' : 'assets/images/favorite_icon_outline.png',
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: car.value.brandName,
                              style: TextStyle(
                                color: ColorUtil.TEXT_PRIMARY,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${car.value.modelName}',
                                  style: TextStyle(
                                    color: ColorUtil.BLUE,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            '${car.value.modelYear.toString()} • ${car.value.fuelType}',
                            style: TextStyle(
                              color: ColorUtil.DARK_GREY,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 95),
                                child: Text(
                                  '${car.value.transmissionType} •',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: ColorUtil.DARK_GREY,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                '${car.value.mileageFormatted} km',
                                style: TextStyle(
                                  color: ColorUtil.DARK_GREY,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7),
                          Text(
                            '${car.value.priceFormatted}',
                            style: TextStyle(
                              color: ColorUtil.DARK_BLUE,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
