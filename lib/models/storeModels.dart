class storeModels {
  int? id;
  String? name;
  double? distance;

  storeModels({this.name, this.id, this.distance});
  storeModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'distance' : distance};
  }
}
