import 'package:asemcode/routes.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
        ),
      ),
      title: 'Asem Code',
      routeInformationParser: const QRouteInformationParser(),
      routerDelegate: QRouterDelegate(routes),
    );
  }
}
