import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlivequery/views/orders/order_screen.dart';
import 'package:flutterlivequery/views/products/product_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;
  const HomeScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
     return widget.isAdmin ? const OrderScreen() : const ProductScreen();
  }
}
