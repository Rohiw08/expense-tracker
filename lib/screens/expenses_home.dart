import 'package:expensetracker/responsive/layout.dart';
import 'package:expensetracker/responsive/mobile_view.dart';
import 'package:expensetracker/responsive/web_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileLayout: MobileLayout(),
      webLayout: WebLayout(),
    );
  }
}
