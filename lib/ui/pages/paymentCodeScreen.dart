import 'package:flutter/material.dart';
import 'package:freshmarket/providers/payment_data_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/LoadPaymentScreen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class PaymentCodeScreen extends StatelessWidget {
  const PaymentCodeScreen({Key? key,this.paymentId}) : super(key: key);
  final String? paymentId;
  @override
  Widget build(BuildContext context) {
    PaymentDataProvider paymentProvider =
        Provider.of<PaymentDataProvider>(context);
    print(paymentProvider);

    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        appBar: AppBar(
          title: Text("Menunggu Pembayaran",
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
            child:  paymentProvider.payment.status == 1 ?  Column(
              children: [
                Text("yeyyy berhasil")
              ],
            ): ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Batas akhir pembayaran",
                          style: subtitleTextStyle.copyWith(fontSize: 14)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${paymentProvider.payment.expireStr}",
                          style: headerTextStyle.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w600))
                    ],
                  )),
                  Text(
                      "${DateFormat('hh:mm').format(DateTime.parse(paymentProvider.payment.expireStr!))}",
                      style: primaryTextStyle.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Text("Mandiri",
                        style: headerTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border.all(color: neutral20)),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kode pembayaran"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${paymentProvider.payment.paymentKey}",
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                              GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            "${paymentProvider.payment.paymentKey}"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: primaryColor,
                                            content: Text(
                                              "Kode Pembayaran berhasil disalin",
                                              textAlign: TextAlign.center,
                                            )));
                                  },
                                  child: Row(
                                    children: [
                                      Text("Salin",
                                          style: primaryTextStyle.copyWith(
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.copy,
                                          color: primaryColor, size: 15)
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Pembayaran"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              "${paymentProvider.payment.amount}"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: primaryColor,
                                              content: Text(
                                                "Nominal pembayaran berhasil di salin",
                                                textAlign: TextAlign.center,
                                              )));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "${CurrencyFormat.convertToIdr(paymentProvider.payment.amount, 0)}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(Icons.copy,
                                            color: primaryColor, size: 15)
                                      ],
                                    ),
                                  )
                                ],
                              )),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadPaymentScreen(
                                paymentId:paymentId,
                              )));
                },
                child: Text("Cek status pembayaran",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  primary: Colors.white,
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
