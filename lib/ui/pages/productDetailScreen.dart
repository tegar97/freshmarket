import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, this.product}) : super(key: key);

  final ProductModels? product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class QtyCubit extends Cubit<int> {
  QtyCubit() : super(1);

  void addQuantity() {
    emit(state + 1);
  }

  void reduceQuantity() {
    if (state != 0) {
      emit(state - 1);
    }
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    QtyCubit qty = QtyCubit();

    CartProvider cartProvider = Provider.of<CartProvider>(context);
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            cartProvider.addCart(widget.product, qty.state);
            Navigator.pushNamed(context, '/cart');
          },
          label: Text(
            'Tambahkan ke keranjang',
            style: headerTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: 80),
          children: [
            Container(
              width: double.infinity,
              height: heightDevice * 0.5,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              color: Color(0xffF2FBF8),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 41.85,
                          height: 41.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 41.85,
                        height: 41.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/cart.png',
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          '$baseUrl/product/${widget.product!.image}',
                          width: double.infinity,
                          height: 206.04,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.product!.name}",
                      style: headerTextStyle.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Berat: ${widget.product!.weight ?? 0 / 1000} gram",
                      style: subtitleTextStyle.copyWith()),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${CurrencyFormat.convertToIdr(widget.product!.price, 0)} ",
                                style: primaryTextStyle.copyWith(
                                    fontSize: 19, fontWeight: FontWeight.w600)),
                            Text("/ kg", style: subtitleTextStyle)
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              qty.reduceQuantity();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xffF3F5F7),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove, color: primaryColor)
                                ],
                              ),
                            ),
                          ),
                          StreamBuilder(
                              stream: qty.stream,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text("1");
                                } else {
                                  return Text("${snapshot.data}");
                                }
                              }),
                          GestureDetector(
                            onTap: () {
                              qty.addQuantity();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff009959),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Product Details",
                      style: headerTextStyle.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 11,
                  ),
                  Text("${widget.product!.description}",
                      style: subtitleTextStyle.copyWith(fontSize: 14)),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: ((widthDevice - 36) / 2) - 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.only(right: 8),
                        height: 67,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/type_logo.png',
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text("100%",
                                    style: typeHeading.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                Text("${widget.product!.productType}",
                                    style: typetitle)
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            top: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            left: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            right: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                          ),
                        ),
                      ),
                      Container(
                        width: ((widthDevice - 36) / 2) - 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.only(left: 8),
                        height: 67,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/expire_icon.png',
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text("${widget.product!.productExp} Year",
                                    style: typeHeading.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                Text("Expiration", style: typetitle)
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            top: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            left: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            right: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: ((widthDevice - 36) / 2) - 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.only(right: 8),
                        height: 67,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/review_icon.png',
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("4.9 ",
                                        style: typeHeading.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    Text("(256)  ",
                                        style: typetitle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ],
                                ),
                                Text("Reviews", style: typetitle)
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            top: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            left: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            right: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                          ),
                        ),
                      ),
                      Container(
                        width: ((widthDevice - 36) / 2) - 8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.only(left: 8),
                        height: 67,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/calori_icon.png',
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text("${widget.product!.productCalori} kcal",
                                    style: typeHeading.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                Text("100 gram", style: typetitle)
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            top: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            left: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            right: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xffF1F1F5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
