import 'package:flutter/material.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/ui/pages/productDetailScreen.dart';
import '../../home/theme.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.widthDevice, required this.product})
      : super(key: key);

  final double widthDevice;
  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      product: product,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        width: widthDevice * 0.43,
        margin: EdgeInsets.only(right: 8),
        height: 214,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Color(0xffF3F5F7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              '$baseUrl/product/${product.image}',
              width: 112,
              height: 98,
            ),
            SizedBox(
              height: 27,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name}",
                        overflow: TextOverflow.ellipsis,
                        style: headerTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${CurrencyFormat.convertToIdr(product.price, 0)}",
                              style: primaryTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text("/ kg",
                              style: subtitleTextStyle.copyWith(fontSize: 12))
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: 36,
                //   height: 36,
                //   margin: EdgeInsets.only(top: 5),
                //   decoration: BoxDecoration(
                //       color: primaryColor,
                //       borderRadius: BorderRadius.circular(100)),
                //   child: Icon(Icons.add,color: Colors.white,),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
