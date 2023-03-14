import 'package:flutter/material.dart';
import 'package:newsly_app/sevices/data_service.dart';

class NewsCategoryViewModel with ChangeNotifier {
  final DataService dataService = DataService();

  List<String> categoryItem = [
    'Latest',
    'Technology',
    'Sports',
    'Fashion',
    'Health'
  ];

  newsCategory() {
    notifyListeners();

    return dataService.newsCategoryStream();
  }
}
