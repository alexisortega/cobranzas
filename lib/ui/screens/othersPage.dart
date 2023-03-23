import 'package:flutter/material.dart';

class othersPage extends StatefulWidget {
  const othersPage({super.key});

  @override
  State<othersPage> createState() => _othersPageState();
}

class _othersPageState extends State<othersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Others")),
    );
  }
}
