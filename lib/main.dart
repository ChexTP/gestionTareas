import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tareas/firebase_options.dart';
import 'package:gestion_tareas/screens/home_screen.dart';
import 'package:gestion_tareas/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Tareas',
      initialRoute: LoginScreen.routename,
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        // RegisterScreen.routename: (context) => const RegisterScreen(),
        HomeScreen.routename: (context)=>  HomeScreen(),
      },
    );
  }
}

