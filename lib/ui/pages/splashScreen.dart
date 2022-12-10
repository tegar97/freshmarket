import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshmarket/providers/category_product_providers.dart';
import 'package:freshmarket/providers/category_providers.dart';
import 'package:freshmarket/providers/connection_providers.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/providers/recipeProviders.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getInit();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  getInit() async {
    Timer(Duration(seconds: 3),() {
       if (_connectionStatus == ConnectivityResult.none) {
      Navigator.pushNamed(context, '/no-internet');
    }
    });
   

    await Provider.of<CategoryProvider>(context, listen: false).getCategory();
    await Provider.of<ProductProvider>(context, listen: false).getProduct();
    await Provider.of<RecipeProvider>(context, listen: false).getRecipe();
    await Provider.of<CategoryProductProviders>(context, listen: false)
        .getCategoryProduct();
    await Provider.of<VoucherProvider>(context, listen: false).getVouchers();

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
            ),
          ],
        ),
      ),
    );
  }
}
