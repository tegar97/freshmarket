import 'package:flutter/material.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/auth_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/category_product_providers.dart';
import 'package:freshmarket/providers/category_providers.dart';
import 'package:freshmarket/providers/classify_provider.dart';
import 'package:freshmarket/providers/connection_providers.dart';
import 'package:freshmarket/providers/get_location_provider.dart';
import 'package:freshmarket/providers/maps_page_provider.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/providers/payment_data_providers.dart';
import 'package:freshmarket/providers/payment_providers.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/providers/recipeProviders.dart';
import 'package:freshmarket/providers/store_provider.dart';
import 'package:freshmarket/providers/track_driver_provider.dart';
import 'package:freshmarket/providers/transaction_providers.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/route/route_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

extension ExtendedString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}




void main() async {
  /// Setup injector
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  return MaterialApp(title: "Get started", home: GetStarted());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProductProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecipeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VoucherProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
        //  ChangeNotifierProvider(
        //   create: (context) => MapProvider(),
        // ),
        
          ChangeNotifierProvider(
          create: (context) => ClassifyProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) =>MyLocationProvider(),
        ),
             ChangeNotifierProvider(
          create: (context) => MapProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => TrackDriverProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigationUtils>().navigatorKey,
        title: 'Freshmarket',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
