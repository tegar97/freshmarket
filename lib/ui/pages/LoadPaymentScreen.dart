import 'package:flutter/material.dart';
import 'package:freshmarket/providers/payment_data_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/paymentCodeScreen.dart';
import 'package:provider/provider.dart';

class LoadPaymentScreen extends StatefulWidget {
  const LoadPaymentScreen({Key? key, this.paymentId}) : super(key: key);
  final String? paymentId;

  @override
  State<LoadPaymentScreen> createState() => _LoadPaymentScreenState();
}

class _LoadPaymentScreenState extends State<LoadPaymentScreen> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  Future<void> getInit() async {
    await Provider.of<PaymentDataProvider>(context, listen: false)
        .getPaymentCode(paymentId: widget.paymentId)
        .then((value) {
      Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context) => PaymentCodeScreen(
                paymentId: widget.paymentId,
              )));
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Sedang menyiapkan pembayaran ..",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
