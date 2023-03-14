import 'package:newsly_app/models/news_model.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNum;
  final String dob;
  List followedCategories;
  final List savedArticle;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNum,
    required this.dob,
    required this.id,
    required this.followedCategories,
    required this.savedArticle,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullName,
      'email': email,
      'phoneNum': phoneNum,
      'dob': dob,
      'followedCategories': followedCategories,
      'savedArticle': savedArticle
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      savedArticle: (map['savedArticle'] as List)
          .map((element) => NewsModel.fromJson(element))
          .toList(),
      followedCategories: map['followedCategories'] as List,
      id: map['id'] as String,
      fullName: map['fullname'] as String,
      email: map['email'] as String,
      phoneNum: map['phoneNum'] as String,
      dob: map['dob'] as String,
    );
  }
}
