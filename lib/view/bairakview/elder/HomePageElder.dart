
import 'package:flutter/material.dart';

class HomePageElder extends StatefulWidget {
  const HomePageElder({super.key});

  @override
  State<HomePageElder> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageElder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            // اكتب الكود هون
          ),
        ),
      ),
    );
  }
}