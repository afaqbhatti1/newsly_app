import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsly_app/view_models/auth_viewmodel.dart';
import 'package:newsly_app/view_models/bottomnavbar_viewmodel.dart';
import 'package:newsly_app/view_models/category_display_viewmodel.dart';
import 'package:newsly_app/view_models/home_viewmodel.dart';
import 'package:newsly_app/view_models/news_category_viewmodel.dart';
import 'package:newsly_app/view_models/onboarding_viewmodel.dart';
import 'package:newsly_app/view_models/saved_articles_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (context) => BottomNavBarViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => SavedArticlesViewModel()),
        ChangeNotifierProvider(create: (context) => NewsCategoryViewModel()),
        ChangeNotifierProvider(create: (context) => CategoryDisplayViewModel()),
        ChangeNotifierProvider(create: (context) => HomeDisplayViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Newsly App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
