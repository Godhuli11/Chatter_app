import 'package:my_threads/models/user_model.dart';

class ReplyModel {
  int? id;
  String? userId;
  int? postId;
  String? reply;
  String? createdAt;
  UserModel? user;

  ReplyModel(
      {this.id,
        this.userId,
        this.postId,
        this.reply,
        this.createdAt,
        this.user});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['reply'] = this.reply;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}


