import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freshmarket/models/VoucherModels.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:freshmarket/ui/Widget/Voucher/voucher_item.dart';

import '../../home/theme.dart';

class VoucherList extends StatelessWidget {
  final bool? isMyVoucher;
  final List<VoucherModels> vouchers;
  const VoucherList({Key? key, required this.vouchers,this.isMyVoucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: vouchers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          VoucherModels voucher = vouchers[index];

          return VoucherItem(
            isMyVoucher: isMyVoucher,
            voucher: voucher,
            
          );
        });
  }
}
