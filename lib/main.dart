import 'package:flutter/material.dart';
import 'package:myapp/welcome_screen.dart'; // Import your WelcomeScreen
import 'package:myapp/main_form_screen.dart'; // Import your MainFormScreen
import 'package:myapp/grading_results_screen.dart'; // Import your GradingResultsScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeafGrader',
      theme: ThemeData(
        primarySwatch: Colors.green, // You can customize your theme here
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define the initial route and other routes
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/mainForm': (context) => const MainFormScreen(),
        '/gradingResults': (context) => GradingResultsScreen(
              // Extract arguments passed during navigation
              gradingData: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ?? {},
            ),
      },
      // If you need custom handling for unknown routes
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //     builder: (context) => const WelcomeScreen(),
      //   );
      // },
    );
  }
}
