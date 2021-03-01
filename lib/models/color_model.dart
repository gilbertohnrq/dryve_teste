class ColorModel {
  String colorId;
  String name;
  bool checked;


  ColorModel({this.colorId, this.name, this.checked});

  ColorModel.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    name = json['name'];
    checked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['name'] = this.name;
    return data;
  }
}