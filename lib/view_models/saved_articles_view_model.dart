import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsly_app/models/news_model.dart';

import '../models/user_model.dart';

class SavedArticlesViewModel extends ChangeNotifier {
  final List<NewsModel> savedArticles = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addArticle(NewsModel news) async {
    savedArticles.add(news);
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'savedArticle': FieldValue.arrayUnion([news.toJson()])
    });
    notifyListeners();
  }

  Future<List> showSavedArticle() async {
    DocumentSnapshot<Map<String, dynamic>> userSnap = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    UserModel user = UserModel.fromJson(userSnap.data()!);
    return user.savedArticle;
  }

  void removeArticle(NewsModel news) async {
    savedArticles.remove(news);
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'savedArticle': FieldValue.arrayRemove([news.toJson()])
    });
    notifyListeners();
  }
}
