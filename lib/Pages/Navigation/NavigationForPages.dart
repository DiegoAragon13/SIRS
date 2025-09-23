import 'package:flutter/material.dart';



// Main container que usa BottomBarWidget
class NavigationForPages extends StatefulWidget {
  const NavigationForPages({super.key});

  @override
  State<NavigationForPages> createState() => _NavigationForPagesState();
}

class _NavigationForPagesState extends State<NavigationForPages> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    // HomePage(),
    //Alerts(),
    //AnalyticsPage(), // Asegúrate de que tu clase sea AnalyticsPage
    //SettingsPage(),  // Asegúrate de que tu clase sea SettingsPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
