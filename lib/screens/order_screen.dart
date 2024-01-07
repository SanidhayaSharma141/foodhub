import 'package:flutter/material.dart';
import 'package:foodhub/widgets/header_order_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fuck off")),
      body: HeaderOrderScreen(),
    );
  }
}
