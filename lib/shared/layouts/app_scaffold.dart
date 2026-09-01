import 'package:flutter/material.dart';
import 'package:habot/shared/layouts/responsive_layout.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(child: ResponsiveLayout(child: body)),
    );
  }
}
