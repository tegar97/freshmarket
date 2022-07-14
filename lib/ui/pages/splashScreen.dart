import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freshmarket/providers/category_providers.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await Provider.of<CategoryProvider>(context, listen: false).getCategory();
    await Provider.of<ProductProvider>(context, listen: false).getProduct();
    
    final prefs = await SharedPreferences.getInstance();
    prefs.get('token');
    print(prefs);

    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, '/on-boarding'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 157,
              height: 106,
            )
          ],
        ),
      ),
    );
  }
}
