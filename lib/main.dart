import 'package:comics/presentation/provider/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart'; // Route faylingizni import qiling

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      initialRoute: AppRoutes.welcome, // Boshlang'ich sahifa
      onGenerateRoute: AppRoutes.onGenerateRoute, // Route boshqaruvi
    );
  }
}
