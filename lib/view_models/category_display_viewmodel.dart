import 'package:flutter/widgets.dart';
import 'package:newsly_app/sevices/data_service.dart';

class CategoryDisplayViewModel with ChangeNotifier {
  final DataService dataService = DataService();

  categoryDisplay(data) {
    return dataService.getCategoryArticlesStream(data);
  }
}
