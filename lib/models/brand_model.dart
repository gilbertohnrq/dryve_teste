class BrandModel {
  String brandId;
  String name;
  bool checked;


  BrandModel({this.brandId, this.name, this.checked});

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    name = json['name'];
    checked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    return data;
  }
}