import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'PaperHealth',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: const Center(child: Text('PHF'))),
      ),
    ),
  );
}

// Separate widget for easy testing/hot reload reference later (or keep inline for now)
// We need to inject `theme: AppTheme.lightTheme` into MaterialApp.
