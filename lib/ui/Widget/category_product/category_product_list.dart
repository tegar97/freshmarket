import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryProductModels.dart';

import '../../home/theme.dart';

class CategortProductItem extends StatelessWidget {
  final List<CategoryProductModels> categoriesProduct;
  const CategortProductItem({Key? key, required this.categoriesProduct})  : super(key: key);



  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: categoriesProduct.length,
        itemBuilder: (context, index) {
          CategoryProductModels categoryProduct = categoriesProduct[index];

          return Container(
            child: Text(categoryProduct.title.toString()),
          );
        });
  }
}
