import 'package:flutter/material.dart';
import 'package:movie_of_depi/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'constants/colors.dart';
import 'controller/providers/movie_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Movies',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colours.scaffoldBgColor,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
