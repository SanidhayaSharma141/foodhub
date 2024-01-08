import 'package:flutter/material.dart';
import 'package:foodhub/widgets/header_order_screen.dart';
import 'package:location/location.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key, required this.location});
  LocationData location;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Hub")),
      body: SafeArea(child: HeaderOrderScreen(location: widget.location)),
    );
  }
}
