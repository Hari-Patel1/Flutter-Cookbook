import 'package:flutter/material.dart';

import 'navigation/main_navigation.dart';
import 'features/onboarding/onboarding_page.dart';
import 'theme/app_theme.dart';

class RecipeFinderApp extends StatefulWidget {
  const RecipeFinderApp({super.key});

  @override
  State<RecipeFinderApp> createState() => _RecipeFinderAppState();
}

class _RecipeFinderAppState extends State<RecipeFinderApp> {
  // Temporary value.
  //
  // Later this will come from local storage so that onboarding
  // is only shown the first time the app is opened.
  bool onboardingComplete = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'RecipeFinder',

      theme: AppTheme.light,

      darkTheme: AppTheme.dark,

      themeMode: ThemeMode.system,

      home: onboardingComplete
          ? const MainNavigation()
          : OnboardingPage(
        onComplete: () {
          setState(() {
            onboardingComplete = true;
          });
        },
      ),
    );
  }
}