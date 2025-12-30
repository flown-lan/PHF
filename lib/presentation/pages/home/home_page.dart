// # Home Page
//
// Description
// 主页容器，包含底部导航栏 (BottomNavigationBar) 和主要的页面切换。
//
// Tabs
// - Timeline: 浏览记录 (TimelinePage).
// - Settings: (Phase 2).
//
// FAB
// - 只有在 Timeline Tab 显示悬浮按钮，用于录入新记录。

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../timeline/timeline_page.dart';
import '../ingestion/ingestion_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TimelinePage(),
    const Center(child: Text('Settings (Phase 2)')),
  ];

  void _onFabPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const IngestionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PaperHealth',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: AppTheme.primaryTeal,
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ) : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.primaryTeal,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
