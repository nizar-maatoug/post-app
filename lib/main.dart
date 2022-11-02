import 'package:flutter/material.dart';

import 'core/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonjour',
      theme: appTheme,
      home: Container(
        child: Text('bonjour'),
      ),
    );
  }
}
