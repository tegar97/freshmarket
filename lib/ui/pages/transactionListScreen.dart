import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:freshmarket/models/transactionModels.dart';
import 'package:freshmarket/providers/store_provider.dart';
import 'package:freshmarket/providers/transaction_providers.dart';
import 'package:freshmarket/ui/global/widget/skeleton.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _ListOutletState();
}

class _ListOutletState extends State<TransactionList> {
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
    await Provider.of<TransactionProviders>(context, listen: false)
        .getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    TransactionProviders transactions =
        Provider.of<TransactionProviders>(context);
    print(transactions);

    return Scaffold(
      appBar: AppBar(
        title: Text("List order",
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
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            FutureBuilder(
                future: delay,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: transactions.transactions!
                            .map((transaction) => TransactionBox(transaction : transaction))
                            .toList());
                  } else {
                    return Skeleton();
                  }
                })

            // Container(
            //   margin: EdgeInsets.only(bottom: 20),
            //   padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            //   decoration: BoxDecoration(
            //       color: alertColorSurface,
            //       borderRadius: BorderRadius.circular(11),
            //       border: Border.all(
            //         color: alertColor,
            //       )),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Fresmarket cileunyi",
            //         style: headerTextStyle.copyWith(
            //             fontSize: 15, fontWeight: FontWeight.w600),
            //       ),
            //       SizedBox(
            //         height: 8,
            //       ),
            //       Text("5km dari jalan raya cikalang 312",
            //           style: subtitleTextStyle.copyWith(fontSize: 13))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class TransactionBox extends StatelessWidget {
  const TransactionBox({
    Key? key,
    required this.transaction
  }) : super(key: key);
  final TransactionModels transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
          color: lightModeBgColor,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: neutral20,
          )),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xffFFF5F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("Confirmed",
                    style: headerTextStyle.copyWith(
                        fontSize: 15,
                        color: Color(0xffFF4949),
                        fontWeight: FontWeight.w600)),
              ),
              Expanded(child: SizedBox()),
              Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                    color: Color(0xffFFF5F5),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.check,
                  color: Color(0xffFF4949),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                    color: lightModeBgColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: neutral20)),
                child: Icon(
                  Icons.card_giftcard,
                  color: neutral60,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                    color: lightModeBgColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: neutral20)),
                child: Icon(
                  Icons.local_shipping,
                  color: neutral60,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                    color: lightModeBgColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: neutral20)),
                child: Icon(
                  Icons.emoji_flags,
                  color: neutral60,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Invoice",
                      style: subtitleTextStyle.copyWith(fontSize: 13)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("${transaction.invoice}",
                      style: headerTextStyle.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dikirim ke",
                      style: subtitleTextStyle.copyWith(fontSize: 13)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Home",
                      style: headerTextStyle.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Pembayaran",
                      style: subtitleTextStyle.copyWith(fontSize: 13)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("${CurrencyFormat.convertToIdr(transaction.amount,0)}",
                      style: headerTextStyle.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
