import 'package:my_threads/models/user_model.dart';

class PostModel {
  int? id;
  String? content;
  String? image;
  String? createdAt;
  int? commentCount;
  int? likeCount;
  String? userId;
  UserModel? user;

  PostModel(
      {this.id,
        this.content,
        this.image,
        this.createdAt,
        this.commentCount,
        this.likeCount,
        this.userId,
        this.user});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    userId = json['user_id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['comment_count'] = this.commentCount;
    data['like_count'] = this.likeCount;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}


