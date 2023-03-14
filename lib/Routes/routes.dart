import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/views/screens/category_disply_screen.dart';
import 'package:newsly_app/views/screens/login_screen.dart';
import 'package:newsly_app/views/screens/news_category_screen.dart';
import 'package:newsly_app/views/screens/onboardng_view.dart';
import 'package:newsly_app/views/screens/saved_artical_screen.dart';
import 'package:newsly_app/views/screens/signup_screen.dart';
import 'package:newsly_app/views/screens/splash_screen.dart';
import 'package:newsly_app/views/screens/home.dart';
import 'package:newsly_app/views/screens/profile_screen.dart';

import '../views/screens/bottomnavbar.dart';
import '../views/screens/main_article.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case onBoardingScreen:
      return MaterialPageRoute(builder: (context) => const OnboardingView());
    case home:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case savedArticles:
      return MaterialPageRoute(
          builder: (context) => const SavedArticlesScreen(),
          settings: settings);
    case newsSource:
      return MaterialPageRoute(builder: (context) => NewsCategoryScreen());
    case logIn:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case signUp:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case bottomNavBar:
      return MaterialPageRoute(builder: (context) => BottomNavBar());
    case profile:
      return MaterialPageRoute(builder: (context) => const ProfilScreen());
    case mainArticle:
      return MaterialPageRoute(
          builder: (context) => const MainArticle(), settings: settings);
    case categortydisplayscreen:
      return MaterialPageRoute(
          builder: (context) => const CategortDisplayScreen(),
          settings: settings);
    default:
      return MaterialPageRoute(
        builder: (_) {
          return const Scaffold(
            body: Center(child: Text('Empty route')),
          );
        },
      );
  }
}
