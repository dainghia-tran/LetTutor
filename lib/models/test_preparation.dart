class TestPreparation {
  String? createdAt;
  int? id;
  String? key;
  String? name;
  String? updatedAt;

  TestPreparation.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    key = json['key'];
    name = json['name'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
