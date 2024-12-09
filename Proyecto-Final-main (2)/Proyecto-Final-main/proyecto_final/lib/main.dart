import 'package:flutter/material.dart';
import 'package:proyecto_final/Pages/home.dart';
import 'package:proyecto_final/Pages/login.dart';
import 'package:proyecto_final/Pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tienda de ropa online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const MyHomePage(),
        '/register': (context) => const RegisterPage()
      },
    );
  }
}
