import 'package:flutter/material.dart';
import 'package:freshmarket/data/content/listPayment.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/payment_providers.dart';
import 'package:freshmarket/ui/Widget/snackbar/snackbar_item.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/LoadPaymentScreen.dart';
import 'package:provider/provider.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({Key? key}) : super(key: key);

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  String? bankSelect = "";

  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
   
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () async {
            String? result = await paymentProvider.pay(
                carts: cartProvider.carts,
                amount: cartProvider.totalPrice(),
                promo: cartProvider.voucher,
                
                api: bankSelect);
            print(bankSelect);
            cartProvider.clearCart();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoadPaymentScreen(
                          paymentId: result,
                        )));
          },
          label: Text('Bayar sekarang'),
          backgroundColor: primaryColor,
        ),
      ),
      appBar: AppBar(
        title: Text("Pembayaran",
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
          tooltip: 'Kembali ke checkout',
          onPressed: () {
            // handle the press
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          GestureDetector(
            child: Container(
              child: Column(
                  children: servicePayment.map((payment) {
                return GestureDetector(
                  onTap: () {
                    print(payment.isAvaible);
                    payment.isAvaible == true
                        ? setState(() {
                            bankSelect = payment.serviceApi;
                          })
                        : showSnackbar(title: 'Sedang gangguan');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: bankSelect == payment.serviceApi
                            ? Color(0xffF2FBF8)
                            : payment.isAvaible == true
                                ? neutral20
                                : alertColorSurface,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: bankSelect == payment.serviceApi
                              ? primaryColor
                              : neutral20,
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                '${payment.serviceLogo}',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("${payment.serviceName} ",
                                  style: headerTextStyle.copyWith(
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                        // Checkbox(
                        //     value: bankSelect ,
                        //     checkColor: Colors.white,
                        //     activeColor: primaryColor,
                        //     onChanged: (val) {
                        //       setState(() {
                        //         bankSelect = payment.serviceName;
                        //       });
                        //     })

                        bankSelect == payment.serviceApi
                            ? Icon(
                                Icons.verified,
                                color: primaryColor,
                              )
                            : SizedBox(
                                height: 40,
                              )
                      ],
                    ),
                  ),
                );
              }).toList()),
            ),
          )
        ],
      )),
    );
  }
}
