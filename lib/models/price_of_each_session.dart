class PriceOfEachSession {
  String? id;
  String? key;
  String? price;
  String? createdAt;
  String? updatedAt;

  PriceOfEachSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
