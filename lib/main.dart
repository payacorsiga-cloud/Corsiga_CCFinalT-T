import 'package:flutter/material.dart';
import 'pages/main_navigation.dart';

void main() {
  runApp(const TrikeFlowApp());
}

class TrikeFlowApp extends StatelessWidget {
  const TrikeFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF17324D);
    const teal = Color(0xFF168C87);

    return MaterialApp(
      title: 'TrikeFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: teal,
          primary: navy,
          secondary: teal,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}
