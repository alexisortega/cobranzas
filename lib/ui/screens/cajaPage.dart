// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CajaPage extends StatefulWidget {
  const CajaPage({super.key});

  @override
  State<CajaPage> createState() => _CajaPageState();
}

class _CajaPageState extends State<CajaPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('CAJA'),
      ),
    );
  }
}
