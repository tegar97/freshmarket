import 'package:flutter/material.dart';
import 'package:freshmarket/ui/pages/AdditionalInformation.dart';
import 'package:freshmarket/ui/pages/LoadPaymentScreen.dart';
import 'package:freshmarket/ui/pages/TrackDriverScreen.dart';
import 'package:freshmarket/ui/pages/addAddressScareen.dart';
import 'package:freshmarket/ui/pages/addressScreen.dart';
import 'package:freshmarket/ui/pages/cartScreen.dart';
import 'package:freshmarket/ui/pages/categoryProductScreen.dart';
import 'package:freshmarket/ui/pages/checkoutScreen.dart';
import 'package:freshmarket/ui/pages/discover.dart';
import 'package:freshmarket/ui/pages/homeScreen.dart';
import 'package:freshmarket/ui/pages/listOutlet.dart';
import 'package:freshmarket/ui/pages/loginScreen.dart';
import 'package:freshmarket/ui/pages/main_pages.dart';
import 'package:freshmarket/ui/pages/noConnectionScreen.dart';
import 'package:freshmarket/ui/pages/onBoardingScreen.dart';
import 'package:freshmarket/ui/pages/paymentCodeScreen.dart';
import 'package:freshmarket/ui/pages/paymentListScreen.dart';
import 'package:freshmarket/ui/pages/productDetailScreen.dart';
import 'package:freshmarket/ui/pages/productSearchScreen.dart';
import 'package:freshmarket/ui/pages/recipeDetailScreen.dart';
import 'package:freshmarket/ui/pages/registerScreen.dart';
import 'package:freshmarket/ui/pages/searchLocationScreen.dart';
import 'package:freshmarket/ui/pages/splashScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SpalashScreen());
      case '/on-boarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
   
      case '/home':
        return MaterialPageRoute(builder: (_) => MainPages());
      case '/product-detail':
        return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      // case '/address':
      //   return MaterialPageRoute(builder: (_) => AddressScreen());
      // case '/add-address':
      //   return MaterialPageRoute(builder: (_) => AddAddress());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckOutScreen());
      case '/category-product':
        return MaterialPageRoute(builder: (_) => CategoryProduct());
      case '/payment-list':
        return MaterialPageRoute(builder: (_) => PaymentListScreen());
      case '/load-payment':
        return MaterialPageRoute(builder: (_) => LoadPaymentScreen());
      case '/payment-code':
        return MaterialPageRoute(builder: (_) => PaymentCodeScreen());
      case '/recipe-detail':
        return MaterialPageRoute(builder: (_) => RecipeDetailScreen());
      case '/recipe':
        return MaterialPageRoute(builder: (_) => Discover());
      case '/list-outlet':
        return MaterialPageRoute(builder: (_) => ListOutlet());
      case '/no-internet':
        return MaterialPageRoute(builder: (_) => NoInternetConnection());
      case '/search-product':
        return MaterialPageRoute(builder: (_) => ProductSearchScreen());
      case '/search-location':
        return MaterialPageRoute(builder: (_) => SearchLocation());
      case '/additional-information':
        return MaterialPageRoute(builder: (_) => AdditionalInformation());
      case '/track-driver':
      return MaterialPageRoute(builder: (_) => TrackDriver());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('Erorr'),
        ),
      );
    });
  }
}
