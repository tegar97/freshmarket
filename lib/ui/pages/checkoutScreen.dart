import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
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
          padding: EdgeInsets.only(bottom: 20),
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
                      Text("Ganti", style: primaryTextStyle)
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: neutral30,
                          )),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Tegar Akmal",
                                  style: headerTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                                      SizedBox(width: 8,),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              SizedBox(width: 8,),
                              Text("+62 812-1797-8079 ",style: subtitleTextStyle)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Jalan raya cikalang 312, kabupaten bandung , jawa barat ",style: subtitleTextStyle)
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(height: 20,),
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
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    height: widthDevice * 0.25,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                             width: widthDevice * 0.25,
                             height: widthDevice * 0.25,
                             margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 11),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(
                                color: primaryColor,
                              )),
                              child: Column(
                                children: [
                                  Text("Rabu",style: subtitleTextStyle),
                                  SizedBox(height: 3,),
                                  Text("26",style: headerTextStyle.copyWith(fontWeight: FontWeight.w600)),
                                                                    SizedBox(
                                height: 3,
                              ),

                                  Text("Juli", style: subtitleTextStyle),
                                ],
                              ),
                        ),
                        Container(
                             width: widthDevice * 0.25,
                             height: widthDevice * 0.25,
                             margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 11),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(
                                color: neutral30,
                              )),
                              child: Column(
                                children: [
                                  Text("Kamis",style: subtitleTextStyle),
                                  SizedBox(height: 3,),
                                  Text("27",style: headerTextStyle.copyWith(fontWeight: FontWeight.w600)),
                                                                    SizedBox(
                                height: 3,
                              ),

                                  Text("Juli", style: subtitleTextStyle),
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
            SizedBox(height: 20,),
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
                  SizedBox(height: 30,),
                  ProductCheckout(),
                  ProductCheckout(),
                  ProductCheckout(),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ProductCheckout extends StatelessWidget {
  const ProductCheckout({
    Key? key,
  }) : super(key: key);

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
              Image.asset(
                'assets/images/product_2.png',
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
                    Text("Fresh Luttce",
                        style: headerTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Berat : 1kg",
                        style: subtitleTextStyle.copyWith(fontSize: 14)),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rp 25.000 ",
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
                  Text("Rp 50.000",
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.w600))
                ],
              )),
             Text("x2",style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}
