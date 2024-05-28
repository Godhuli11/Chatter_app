import 'package:my_threads/models/user_model.dart';

class NotificationModel {
  int? id;
  int? postId;
  String? notification;
  String? createdAt;
  String? userId;
  UserModel? user;

  NotificationModel(
      {this.id,
        this.postId,
        this.notification,
        this.createdAt,
        this.userId,
        this.user});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    notification = json['notification'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['notification'] = this.notification;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}


