import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/ui/Widget/snackbar/snackbar_item.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/helper/convertRupiah.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherItem extends StatelessWidget {
  final VoucherModels voucher;
  final bool? isMyVoucher;
  const VoucherItem({Key? key, required this.voucher, this.isMyVoucher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(top: 15),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Detail Promo",
                              style: headerTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: neutral90),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Dengan menggunakan promotional code yang ada pada freshmarket , anda telah menyetuji S&K yang berlaku",
                              style: subtitleTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: neutral70),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Minimum pembelian : ",
                                  style: subtitleTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: neutral70),
                                ),
                                Text(
                                  "Rp. ${CurrencyFormat.convertToIdr(voucher.minOrder, 0)}",
                                  style: subtitleTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: neutral70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Promo expired : ",
                                  style: subtitleTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: neutral70),
                                ),
                                Text(
                                  "Rp. ${voucher.expiredAt}",
                                  style: subtitleTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: neutral70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isMyVoucher ?? false
                          ? ElevatedButton(
                              onPressed: () async {
                                cartProvider.usePromo();
                                cartProvider.getVoucherInfo(voucher);
                                cartProvider.getDiscountvalue(
                                    voucher.discountPercetange?.toDouble() ??
                                        0);
                                navigate.pop();
                                showSnackbar(title: 'BERHASIL');
                                print(cartProvider.isUseVoucher);
                              },
                              child: Text("Gunakan",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                primary: Colors.white,
                                minimumSize: Size(double.infinity, 60),
                                // shape: const RoundedRectangleBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(23)),
                                // ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                String? token = prefs.getString('token');
                                final voucherProv =
                                    VoucherProvider.instance(context);
                                print(token);

                                try {
                                  voucherProv.claimVoucher(token, voucher.code);
                                   voucherProv.getMyVoucher();
                                  
                                  navigate.pushTo('/home');

                                } catch (e) {
                                  // showSnackbar(
                                  //     floating: true,
                                  //     title: "Failed claim vouchers",
                                  //     color: Colors.red,
                                  //     isError: true);
                                  // navigate.pop();
                                }
                              },
                              child: Text("Klaim",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                primary: Colors.white,
                                minimumSize: Size(double.infinity, 60),
                                // shape: const RoundedRectangleBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(23)),
                                // ),
                              ),
                            ),
                    ]))));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: neutral30,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(voucher.code ?? 'Judul promo',
                style: subtitleTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: neutral90)),
            SizedBox(
              height: 5,
            ),
            Text(
                "${voucher.discountPercetange} % Potongan dengan minimum pembelian ${voucher.minOrder}",
                style: subtitleTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: neutral70)),
          ],
        ),
      ),
    );
  }
}
