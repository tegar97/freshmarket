import 'package:flutter/material.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:intl/intl.dart';
import 'package:freshmarket/helper/convertRupiah.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key? key, this.carts}) : super(key: key);
  List<CartModels>? carts;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final Future<String> delay = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await Provider.of<AddressProvider>(context, listen: false).getMyAddress();
  }

  final _currentDate = DateTime.now();

  final _dayFormatter = DateFormat('d');

  final _dayFormatterEng = DateFormat('EEE');

  final _monthFormatter = DateFormat('MMM');

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    CartProvider cart = Provider.of<CartProvider>(context);
    print(addressProvider.address.city);
    final dates = <Widget>[];

    for (int i = 1; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));
      dates.add(Column(
        children: [
          Text(_dayFormatterEng.format(date), style: subtitleTextStyle),
          SizedBox(
            height: 3,
          ),
          Text(_dayFormatter.format(date),
              style: headerTextStyle.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(
            height: 3,
          ),
          Text(_monthFormatter.format(date), style: subtitleTextStyle),
        ],
      ));
    }

    double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/payment-list');
          },
          label: Text('Bayar'),
          backgroundColor: primaryColor,
        ),
      ),
      backgroundColor: Color(0xffFAFAFA),
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
          padding: EdgeInsets.only(bottom: 60),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alamat",
                        style: headerTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/address');
                          },
                          child: Text("Ganti", style: primaryTextStyle))
                    ],
                  ),
                  FutureBuilder(
                      future: delay,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return addressProvider.myAddress.label == null
                              ? Text("no data")
                              : Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 11),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border.all(
                                        color: neutral30,
                                      )),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${addressProvider.myAddress.label ?? "no data"}",
                                              style: headerTextStyle.copyWith(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              "${addressProvider.myAddress.phoneNumber ?? "no data"} ",
                                              style: subtitleTextStyle)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "${addressProvider.myAddress.fullAddress ?? "no data"} ",
                                          style: subtitleTextStyle)
                                    ],
                                  ));
                        } else {
                          return Text("Loading ...");
                        }
                      })
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih hari pengiriman",
                        style: headerTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/images/icon_store_location.png',
                              width: 40),
                          Image.asset(
                            'assets/images/icon_line.png',
                            height: 30,
                          ),
                          Image.asset(
                            'assets/images/icon_your_address.png',
                            width: 40,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Outlet terdekat',
                              style: headerTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 3,
                          ),
                          Text('Freshmarket cileunyi',
                              style: subtitleTextStyle.copyWith()),
                          SizedBox(
                            height: 35,
                          ),
                          Text('Lokasi Kamu',
                              style: headerTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 3,
                          ),
                          Text('${addressProvider.myAddress.label}',
                              style: subtitleTextStyle.copyWith()),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih hari pengiriman",
                        style: headerTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: widthDevice * 0.25,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dates.map((date) {
                        var index = dates.indexOf(date);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: DateBox(
                            id: index,
                            widthDevice: widthDevice,
                            date: date,
                            selectedIndex: selectedIndex,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Detail",
                        style: headerTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: widget.carts!
                        .map((cart) => GestureDetector(
                            child: ProductCheckout(product: cart)))
                        .toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Summary",
                        style: headerTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Jumlah product")),
                          Text("${cart.totalItem()}",
                              style: headerTextStyle.copyWith(
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(child: Text("Total harga product")),
                          Text(
                              "${CurrencyFormat.convertToIdr(cart.totalPrice(), 0)}",
                              style: headerTextStyle.copyWith(
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(child: Text("Ongkos kirim")),
                          Text("Free",
                              style: headerTextStyle.copyWith(
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:  neutral20,
                          border: Border.all(color: neutral20)
                        ),
                        
                      ),
                      SizedBox(height: 20,),
                         Row(
                        children: [
                          Expanded(child: Text("Total")),
                          Text(                              "${CurrencyFormat.convertToIdr(cart.totalPrice(), 0)}",

                              style: headerTextStyle.copyWith(
                                  fontWeight: FontWeight.w600))
                        ],
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
}

class DateBox extends StatelessWidget {
  DateBox(
      {Key? key,
      required this.date,
      required this.widthDevice,
      required this.id,
      this.selectedIndex})
      : super(key: key);

  final double widthDevice;
  final Widget date;
  int? id;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthDevice * 0.25,
      height: widthDevice * 0.25,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: selectedIndex == id ? primaryColor : neutral20,
          )),
      child: Column(
        children: [date],
      ),
    );
  }
}

class ProductCheckout extends StatelessWidget {
  const ProductCheckout({Key? key, required this.product}) : super(key: key);
  final CartModels product;

  @override
  Widget build(BuildContext context) {
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
                '$baseUrl/product/${product.product!.image}',
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
                    Text("${product.product!.name}",
                        style: headerTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Berat : ${(((product.product!.weight ?? 0).toInt() * (product.quantity ?? 0).toInt()) / 10000).toInt()} kg",
                        style: subtitleTextStyle.copyWith(fontSize: 14)),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${CurrencyFormat.convertToIdr(product.product!.price, 0)} ",
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
                  Text("${CurrencyFormat.convertToIdr(product.total, 0)}",
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.w600))
                ],
              )),
              Text("x${product.quantity}",
                  style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}
