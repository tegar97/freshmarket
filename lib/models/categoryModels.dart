class CategoryModels {
  int? id;
  String? name;
  int? bgColor;
  String? icon;

  CategoryModels({this.name, this.id, this.bgColor, this.icon});
  CategoryModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bgColor = int.parse(json['bgColor']);
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'bgColor': bgColor};
  }
}
