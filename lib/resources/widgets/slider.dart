import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final String image, title, subtitle;

  const SliderWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage(image)),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text(subtitle),
        const SizedBox(height: 25),
      ],
    );
  }
}
