import 'package:flutter/widgets.dart';
import 'package:newsly_app/sevices/data_service.dart';

class HomeDisplayViewModel with ChangeNotifier {
  final DataService dataService = DataService();

  homeSlideDisplayList() {
    return dataService.homeSlideNewsListStream();
  }

  homeDisplayList() {
    return dataService.homeNewsListStream();
  }
}
