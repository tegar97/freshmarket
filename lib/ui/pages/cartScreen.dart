import 'package:flutter/material.dart';
import 'package:freshmarket/data/content/populer_product.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/checkoutScreen.dart';
import 'package:freshmarket/ui/pages/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    double widthDevice = MediaQuery.of(context).size.width;
    print('check ${addressProvider.listAddress.length}');
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 70,
        child: cartProvider.carts.length > 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  if (addressProvider.listAddress.length > 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutScreen(
                                  carts: cartProvider.carts,
                                )));
                  } else {
                    Navigator.pushNamed(context, '/address');
                  }
                },
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total pembayaran",
                            style: whiteTextStyle.copyWith(fontSize: 12)),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                            "${CurrencyFormat.convertToIdr(cartProvider.totalPrice(), 0)}",
                            style: whiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text("Checkout",
                        style: whiteTextStyle.copyWith(
                            fontWeight: FontWeight.w600))
                  ],
                ),
                backgroundColor: primaryColor,
              )
            : null,
      ),
      appBar: AppBar(
        title: Text("Cart",
            style: headerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: lightModeBgColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          tooltip: 'Kembali ke halaman product',
          onPressed: () {
            // handle the press
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
          Container(
              color: lightModeBgColor,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Column(
                children: [
                  Container(
                    child: Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      width: double.infinity,
                      color: secondaryColor,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Gratis ongkir minimum belanja Rp 50.000",
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  cartProvider.carts.length > 0
                      ? Column(
                          children: cartProvider.carts
                              .map((product) => CartBox(
                                    cart: product,
                                  ))
                              .toList())
                      : Column(
                          children: [
                            Text("Opsss keranjang masih kosong nih",
                                style: headerTextStyle.copyWith(fontSize: 16)),
                          ],
                        )
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            color: lightModeBgColor,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yang menarik buat kamu",
                  style: headerTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "mungkin kamu suka ini",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: widthDevice - 36,
                      height: 214,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: productProvider.products
                              .map((product) => ProductContainer(
                                  widthDevice: widthDevice, product: product))
                              .toList()),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: lightModeBgColor,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lagi ngetrend",
                  style: headerTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "product ini lagi banyak dibeli ",
                  style: subtitleTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    // Container(
                    //   width: widthDevice - 32,
                    //   height: 214,
                    //   child: ListView.builder(
                    //     itemCount: productPopuler.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return ProductContainer(
                    //           widthDevice: widthDevice,
                    //           title: productPopuler[index].name,
                    //           image: productPopuler[index].image);
                    //     },
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class CartBox extends StatelessWidget {
  const CartBox({Key? key, this.cart}) : super(key: key);
  final CartModels? cart;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: neutral30,
          )),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                '$baseUrl/product/${cart!.product!.image}',
                width: 51,
                height: 51,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${cart!.product!.name}",
                        style: headerTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Berat : ${(((cart!.product!.weight ?? 0).toInt() * (cart!.quantity ?? 0).toInt()) / 10000).toInt()} kg",
                        style: subtitleTextStyle.copyWith(fontSize: 14)),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${CurrencyFormat.convertToIdr(cart!.product!.price, 0)}",
                      style: headerTextStyle.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  Text(
                    "/ kg",
                    style: subtitleTextStyle.copyWith(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Text("Total : ", style: subtitleTextStyle),
                  Text("${CurrencyFormat.convertToIdr(cart!.total, 0)}",
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.w600))
                ],
              )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffF3F5F7),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        cartProvider.reduceQuantity(cart!.id!);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove,
                            color: primaryColor,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("${cart!.quantity}"),
                  Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff009959),
                    ),
                    child: GestureDetector(
                      onTap: (() {
                        cartProvider.addQuantity(cart!.id!);
                      }),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 20)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
