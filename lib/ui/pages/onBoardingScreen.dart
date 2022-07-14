import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshmarket/data/content/onBoarding.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/auth_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  PageController? _controller;

  bool isAuth = false;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _checkIfLoggedIn();

    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    }
  }
@override



  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: EdgeInsets.only(top: 43, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${contents[i].title}",
                                style: headerTextStyle.copyWith(
                                    fontSize: 28, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${contents[i].description}",
                                textAlign: TextAlign.center,
                                style: subtitleTextStyle2.copyWith(
                                    fontSize: 16,
                                    height: 1.6,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 30,
                            ),
                            Image.asset(
                              '${contents[i].image}',
                              width: 324,
                              height: 355,
                            ),
                          ],
                        ),
                      );
                    })),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(contents.length, (index) => BubbleDot(index)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text("Buat akun ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      primary: Colors.white,
                      minimumSize: Size(double.infinity, 60),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Udah punya akun ?  ",
                        style: blackTextStyle.copyWith(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          "Login sekarang ",
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container BubbleDot(index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ? primaryColor : Color(0xffCCCCCC)),
    );
  }
}
