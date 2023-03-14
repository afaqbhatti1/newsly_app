import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/resources/widgets/slider.dart';
import 'package:newsly_app/view_models/onboarding_viewmodel.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingViewModel>(
      builder: (context, onboardingViewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                      onPageChanged: (value) {
                        onboardingViewModel.updatecurrentpage(value);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: onboardingViewModel.onBoardingData.length,
                      itemBuilder: (context, index) {
                        return SliderWidget(
                          title: onboardingViewModel.onBoardingData[index]
                              ['title']!,
                          subtitle: onboardingViewModel.onBoardingData[index]
                              ['subtitle']!,
                          image: onboardingViewModel.onBoardingData[index]
                              ['image']!,
                        );
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingViewModel.onBoardingData.length,
                          (int index) => onboardingViewModel.buildDot(index),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, logIn);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xff22A45D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'GET STARTED',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SFProText',
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
