import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/cartScreen.dart';
import 'package:freshmarket/ui/pages/discover.dart';
import 'package:freshmarket/ui/pages/homeScreen.dart';
import 'package:freshmarket/ui/pages/profileScreen.dart';
import 'package:freshmarket/ui/pages/transactionListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentIndex = 0;

  Widget cartButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
      child: Image.asset(
        'assets/images/icon_cart.png',
        width: 20,
        height: 20,
        color: Colors.white,
      ),
      backgroundColor: primaryColor,
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Discover();
      case 2:
        return TransactionList();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  Widget customButtomNav() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: lightModeBgColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            print(value);
            setState(() {
              currentIndex = value;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/images/home_icon.png',
                  width: 21,
                  color: currentIndex == 0 ? primaryColor : Color(0xffDBDBDB),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/images/product_icon.png',
                  width: 21,
                  color: currentIndex == 1 ? primaryColor : Color(0xffDBDBDB),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/images/order_icon.png',
                  width: 21,
                  color: currentIndex == 2 ? primaryColor : Color(0xffDBDBDB),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/images/icon_profile.png',
                  width: 21,
                  color: currentIndex == 3 ? primaryColor : Color(0xffDBDBDB),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customButtomNav(),
      body: Center(
        child: body(),
      ),
    );
  }
}
