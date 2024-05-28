class UserModel {
  String? email;
  String? createdAt;
  Metadata? metadata;

  UserModel({this.email, this.metadata , this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    createdAt = json['created_at'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? sub;
  String? name;
  String? email;
  String? image;
  String? description;
  bool? emailVerified;
  bool? phoneVerified;

  Metadata(
      {this.sub,
        this.name,
        this.email,
        this.image,
        this.description,
        this.emailVerified,
        this.phoneVerified});

  Metadata.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    description = json['description'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub'] = this.sub;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['description'] = this.description;
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    return data;
  }
}