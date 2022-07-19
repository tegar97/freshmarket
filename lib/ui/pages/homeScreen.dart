import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshmarket/data/content/populer_product.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/models/userModels.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/auth_providers.dart';
import 'package:freshmarket/providers/category_product_providers.dart';
import 'package:freshmarket/providers/category_providers.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/ui/Widget/category.dart';
import 'package:freshmarket/ui/global/widget/banner.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/addressScreen.dart';
import 'package:freshmarket/ui/pages/productDetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    print(localStorage.getString('token')!);
    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
    await Provider.of<AddressProvider>(context, listen: false).getAllAddress();
  }

  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CategoryProductProviders categoryProductProvider =
        Provider.of<CategoryProductProviders>(context);
    print(categoryProductProvider.categories.length);
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: 20),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/avatar.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selamat pagi!",
                                  style:
                                      subtitleTextStyle.copyWith(fontSize: 13),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("${name}",
                                    style: headerTextStyle.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/address');
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: primaryColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 41,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/recipe');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 138,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/bannerMain.jpg"),
                        fit: BoxFit.fill,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coupon_icon.png',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Ada 5 voucher nganggur nih",
                                  style: primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kategori 😋",
                    style: headerTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 112,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: categoryProvider.categories
                            .map((category) => CategoryBox(
                                  category: category,
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
                padding: EdgeInsets.only(left: 16), child: CaraouselBanner()),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sedang Populer 🔥",
                    style: headerTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: widthDevice - 16,
                        height: 214,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: productProvider.products
                                .map((product) => ProductContainer(
                                    widthDevice: widthDevice, product: product))
                                .toList()),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
                children: categoryProductProvider.categories.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${category.name}",
                            style: headerTextStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 5,),
                          Image.network( '$baseUrl/icon/${category.icon}',width: 20,height: 20,
                          )
                        ],

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: widthDevice - 16,
                            height: 214,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: category.products!
                                    .map((product) => ProductContainer(
                                        widthDevice: widthDevice,
                                        product: product))
                                    .toList()),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList())
          ],
        ),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer(
      {Key? key, required this.widthDevice, required this.product})
      : super(key: key);

  final double widthDevice;
  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      product: product,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        width: widthDevice * 0.43,
        margin: EdgeInsets.only(right: 8),
        height: 214,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Color(0xffF3F5F7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              '$baseUrl/product/${product.image}',
              width: 112,
              height: 98,
            ),
            SizedBox(
              height: 27,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name}",
                        overflow: TextOverflow.ellipsis,
                        style: headerTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${CurrencyFormat.convertToIdr(product.price, 0)}",
                              style: primaryTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text("/ kg",
                              style: subtitleTextStyle.copyWith(fontSize: 12))
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: 36,
                //   height: 36,
                //   margin: EdgeInsets.only(top: 5),
                //   decoration: BoxDecoration(
                //       color: primaryColor,
                //       borderRadius: BorderRadius.circular(100)),
                //   child: Icon(Icons.add,color: Colors.white,),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
