import 'package:featherfind/components/navbar.dart';
import 'package:featherfind/providers/recordingprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Recordingprovider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Navbar(),
      ),
    );
  }
}
