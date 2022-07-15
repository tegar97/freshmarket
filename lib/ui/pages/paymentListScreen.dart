import 'package:flutter/material.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/payment_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/LoadPaymentScreen.dart';
import 'package:provider/provider.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({Key? key}) : super(key: key);

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  bool bankSelect = false;

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
                carts: cartProvider.carts, amount: cartProvider.totalPrice());
            print(result);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoadPaymentScreen(
                        paymentId: result,
                        )));          },
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
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/bca.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("BCA Virtual account ",
                          style: headerTextStyle.copyWith(
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ),
                Checkbox(
                    value: bankSelect,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (val) {
                      setState(() {
                        bankSelect = val!;
                      });
                    })
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: neutral20,
                )),
          )
        ],
      )),
    );
  }
}
