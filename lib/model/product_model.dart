class ItemModel {
  int? id;
  String? name;
  int? cost;
  int? quantity;
  int? locationId;
  int? familyId;

  ItemModel(
      {this.id,
      this.name,
      this.cost,
      this.quantity,
      this.locationId,
      this.familyId});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cost = json['cost'];
    quantity = json['quantity'];
    locationId = json['locationId'];
    familyId = json['familyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cost'] = cost;
    data['quantity'] = quantity;
    data['locationId'] = locationId;
    data['familyId'] = familyId;
    return data;
  }
}
