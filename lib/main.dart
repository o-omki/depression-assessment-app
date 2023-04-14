import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:serenity_space/screens/splash_screen.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //start app in full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // for setting orientation to portrait only mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Serenity Space",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
