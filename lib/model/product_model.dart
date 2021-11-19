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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['quantity'] = this.quantity;
    data['locationId'] = this.locationId;
    data['familyId'] = this.familyId;
    return data;
  }
}
