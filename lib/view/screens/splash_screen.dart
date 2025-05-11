import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
 import 'fav2.dart';
import 'home_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);


    _checkConnectionAndNavigate();
  }

  Future<void> _checkConnectionAndNavigate() async {

    await Future.delayed(const Duration(seconds: 5));


    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
          'My Movies',
          style: TextStyle(
          color: Colors.red,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: 5,
              ),
                ),
        ),
    ));
  }
}
