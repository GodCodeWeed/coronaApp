import 'package:flutter/material.dart';
import './screens/onboarding_screen.dart';
import 'package:get_it/get_it.dart';
import './Services.dart';
void main() {

  runApp(MyApp());
  setupLocator();
}


void setupLocator()
{

  GetIt.I.registerLazySingleton(()=> Service());
 
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

