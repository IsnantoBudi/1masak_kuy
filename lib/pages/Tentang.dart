import 'package:flutter/material.dart';
class Tentang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Tentang Aplikasi')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 90.0,
            child: Image.asset('assets/logo.png',),
          ),
        ),
      ),
    );
  }
}