import 'package:flutter/material.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/models/cartModels.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/payment_providers.dart';
import 'package:freshmarket/providers/store_provider.dart';
import 'package:freshmarket/ui/Widget/loading/loading_typeHorizontal.dart';
import 'package:freshmarket/ui/Widget/voucher_list/voucher_list.dart';
import 'package:freshmarket/ui/global/widget/skeleton.dart';
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
    // await Provider.of<AddressProvider>(context, listen: false).getSelectedAddress();
    await Provider.of<StoreProvider>(context, listen: false).getNearStore();
  }

  final _currentDate = DateTime.now();

  final _dayFormatter = DateFormat('d');

  final _dayFormatterEng = DateFormat('EEE');

  final _monthFormatter = DateFormat('MMM');

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    StoreProvider nearOutlet = Provider.of<StoreProvider>(context);
    CartProvider cart = Provider.of<CartProvider>(context);
    PaymentProvider paymentProv = Provider.of<PaymentProvider>(context);

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
      floatingActionButton: FutureBuilder(
        future: delay,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('outlet ${nearOutlet.store.distance}');
            return (nearOutlet.store.distance ?? 0) < 25
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context, '/payment-list');
                      },
                      label: Text('Bayar'),
                      backgroundColor: primaryColor,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        //temporarly
                        // Navigator.pushNamed(context, '/payment-list');
                      },
                      label: Text('Bayar'),
                      backgroundColor: neutral60,
                    ),
                  );
          } else {
            return SizedBox();
          }
        },
      ),
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        title: Text("Checkout",
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
            cart.unusedPromo();
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
                  AddressBoxContainer()
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
              child: FutureBuilder(
                  future: delay,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Lokasi pengiriman",
                                  style: headerTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/list-outlet');
                                  },
                                  child: Text("Lihat list outlet",
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 12)))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          (nearOutlet.store.distance ?? 0) > 25
                              ? Text(
                                  "Uppss sepertinya kami belum tersedia untuk wilayah kamu :(",
                                  style: headerTextStyle.copyWith(
                                      color: alertColor),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/icon_store_location.png',
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: widthDevice * 0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Outlet terdekat (${(nearOutlet.store.distance ?? 0) < 1 ? (((nearOutlet.store.distance ?? 0) * 1000).toInt()) : nearOutlet.store.distance!.toInt()} ${(nearOutlet.store.distance ?? 0) < 1 ? 'M' : 'KM'})',
                                              style: headerTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text("${nearOutlet.store.name}",
                                              style:
                                                  subtitleTextStyle.copyWith()),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Text('Lokasi Kamu',
                                              style: headerTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              "${addressProvider.selectedAddress?.fullAddress}",
                                              style:
                                                  subtitleTextStyle.copyWith()),
                                          SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      );
                    } else {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lokasi pengiriman",
                                  style: headerTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Skeleton()
                          ]);
                    }
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                color: lightModeBgColor,
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kode Promo",
                          style: headerTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                        onTap: (() {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.92,
                                color: Colors.white,
                                child: Scaffold(
                                    body:
                                        VoucherButtomSheet(isMyVoucher: true))),
                          );
                        }),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Voucher",
                              style: subtitleTextStyle.copyWith(fontSize: 14),
                            )),
                            Text(
                              "Pilih voucher",
                              style: subtitleTextStyle.copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: neutral70, size: 15)
                          ],
                        ))
                  ],
                )),
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
                        "Pengiriman",
                        style: headerTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  
                  ListTile(
                    title: const Text('Pesan Antar'),
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),

                    selectedColor: primaryColor,
                    leading: Radio<DeliveryType>(
                      value: DeliveryType.courir,
                          fillColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor),
                      groupValue: paymentProv.deliveryType,
                      onChanged: (DeliveryType? value) {
                        paymentProv.changeDeliveryType(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Self Pickup'),
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),

                    leading: Radio<DeliveryType>(
                      value: DeliveryType.pickup,
                        fillColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor),
                      groupValue: paymentProv.deliveryType,
              
                      onChanged: (DeliveryType? value) {
                        setState(() {
                          paymentProv.changeDeliveryType(value);
                        });
                      },
                    ),
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
                              "${CurrencyFormat.convertToIdr(cart.totalPriceProduct(), 0)}",
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
                      SizedBox(
                        height: 20,
                      ),
                      cart.isUseVoucher ?? false
                          ? Row(
                              children: [
                                Expanded(child: Text("Potongan harga")),
                                Text(
                                    "${CurrencyFormat.convertToIdr(cart.discountValue, 0)}",
                                    style: headerTextStyle.copyWith(
                                        fontWeight: FontWeight.w600))
                              ],
                            )
                          : Row(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: neutral20,
                            border: Border.all(color: neutral20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Total")),
                          Text(
                              "${CurrencyFormat.convertToIdr(cart.totalPrice(), 0)}",
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

class AddressBoxContainer extends StatelessWidget {
  AddressBoxContainer();
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, addressProv, _) {
      print(addressProv.selectedAddress);
      if (addressProv.listAddress == null && !addressProv.onSearch) {
        addressProv.getListAddress();
        addressProv.getSelectedAddress();
        return const Text("loading");
      }
      if (addressProv.listAddress == null && addressProv.onSearch) {
        return const Text("loading");
      }

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: neutral30,
            )),
        child: Text("${addressProv.selectedAddress?.fullAddress ?? "no data"}",
            style: headerTextStyle.copyWith(
                fontSize: 15, fontWeight: FontWeight.w500)),
      );
    });
  }
}
