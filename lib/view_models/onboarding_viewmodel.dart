import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentPage = 0;

  List<Map<String, String>> onBoardingData = [
    {
      'title': 'All your favorites',
      'subtitle':
          'Order from the best local restaurants\n with easy, on-demand delivery.',
      'image': 'assets/images/slide_1.jpg',
    },
    {
      'title': 'Free delivery offers',
      'subtitle':
          'Free delivery for new customers via Apple\n Pay and others payment methods.',
      'image': 'assets/images/slide_2.jpg',
    },
    {
      'title': 'Choose your food',
      'subtitle':
          'Easily find your type of food craving and\n you’ll get delivery in wide range.',
      'image': 'assets/images/slide_3.jpg',
    },
  ];

  void updatecurrentpage(int value) {
    currentPage = value;
    notifyListeners();
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentPage == index
            ? const Color(0xff22A45D)
            : const Color(0xff868686),
      ),
    );
  }
}
