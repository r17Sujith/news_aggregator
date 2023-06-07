
import 'package:flutter/material.dart';
import 'package:twenty4_hours/Provider/GaurdianNewsProvider.dart';
import 'package:provider/provider.dart';
import 'package:twenty4_hours/Screens/LandingPage.dart';
import 'package:twenty4_hours/Screens/TopicSelectionPage.dart';
import 'package:twenty4_hours/Utils/SharedPreference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GuardianNewsProvider(),
      child: MaterialApp(
        title: 'Twenty4 Hours News',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: sharedPrefs.favoritesSelected!=null&&sharedPrefs.favoritesSelected!?const LandingPage():const TopicSelectionPage(),
      ),
    );
  }
}
