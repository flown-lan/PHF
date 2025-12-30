import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/pages/home/home_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'PaperHealth',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          '/home': (context) => const HomePage(),
        },
      ),
    ),
  );
}

// Separate widget for easy testing/hot reload reference later (or keep inline for now)
// We need to inject `theme: AppTheme.lightTheme` into MaterialApp.
