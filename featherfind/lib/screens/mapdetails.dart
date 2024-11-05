import 'package:featherfind/components/detailscard.dart';
import 'package:flutter/material.dart';

class MapDetails extends StatefulWidget {
  const MapDetails({super.key});

  @override
  State<MapDetails> createState() => _MapDetailsState();
}

class _MapDetailsState extends State<MapDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Detailscard(),
    );
  }
}