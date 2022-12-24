import 'package:flutter/material.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/ui/Widget/Voucher/voucher_list.dart';
import 'package:freshmarket/ui/Widget/loading/loading_listview.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherButtomSheet extends StatelessWidget {
  final bool? isMyVoucher;
  const VoucherButtomSheet({Key? key,this.isMyVoucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              Text(
               isMyVoucher ?? false ? "Voucher saya " : "Promo hari ini ",
                textAlign: TextAlign.center,
                style: subtitleTextStyle2.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: neutral90),
              ),
              GestureDetector(
                  onTap: () {
                    final voucherProv = VoucherProvider.instance(context);
                    voucherProv.clearVouchers();
                  },
                  child: Icon(Icons.refresh, size: 20))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // TextFormField(
          //   style: subtitleTextStyle2.copyWith(
          //       color: neutral70, fontWeight: FontWeight.w500),
          //   decoration: InputDecoration(
          //     fillColor: Color(0xffEDEDED),
          //     suffix: GestureDetector(
          //         child: Text(
          //           "Apply",
          //           style: subtitleTextStyle2.copyWith(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w600,
          //               color: primaryColor),
          //         ),
          //         onTap: () {
          //           print("ok");
          //         }),

          //     filled: true,
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(13),
          //       borderSide: BorderSide(color: neutral20, width: 1),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(13),
          //       borderSide: BorderSide(color: neutral20, width: 1.5),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(13),
          //       borderSide: BorderSide(color: alertColor, width: 1.5),
          //     ),
          //     disabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(13),
          //       borderSide: BorderSide(color: Color(0xffEDEDED), width: 1.5),
          //     ),
          //     focusColor: Colors.red,
          //     labelStyle: TextStyle(color: primaryColor),
          //     hintText: 'Kode Promosi',

          //     contentPadding: EdgeInsets.all(14), // Added this
          //   ),
          // ),
         
          // Text(
          // isMyVoucher ?? false ? "Voucher saya " : "Promo tersedia ",
          //   style: subtitleTextStyle2.copyWith(
          //       fontSize: 17, fontWeight: FontWeight.w600, color: neutral90),
          // ),
          SizedBox(
            height: 20,
          ),
        isMyVoucher ?? false ?  _MyVoucherList() : _VoucherListWidget()
        ],
      ),
    );
  }
}

class _VoucherListWidget extends StatelessWidget {
  _VoucherListWidget();
  Widget build(BuildContext context) {
    return Consumer<VoucherProvider>(builder: (context, voucherProv, _) {
      if (voucherProv.voucher == null) {
        voucherProv.getAvailableVoucher();
        return const LoadingListView();
      }
      if (voucherProv.voucher!.isEmpty) {
        return Text('Maaf,belum ada promo untuk sekarang ');
      }

      return VoucherList( isMyVoucher: false,vouchers: voucherProv.voucher!);
    });
  }
}

class _MyVoucherList extends StatelessWidget {
  _MyVoucherList();
  Widget build(BuildContext context) {
    return Consumer<VoucherProvider>(builder: (context, voucherProv, _) {
      if (voucherProv.myVouchers == null) {
        voucherProv.getMyVoucher();
        return const LoadingListView();
      }
      if (voucherProv.myVouchers!.isEmpty) {
        return Text('Opps sepertinya anda belum mempunyai voucher apapun ');
      }

      return VoucherList(isMyVoucher : true , vouchers: voucherProv.myVouchers!);
    });
  }
}
