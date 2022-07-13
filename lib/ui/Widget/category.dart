import 'package:flutter/material.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/ui/home/theme.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);
  final CategoryModels category;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Container(
      width: widthDevice * 0.30,
      height: 112,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: Color(category.bgColor!), borderRadius: BorderRadius.circular(17)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('$baseUrl/icon/${category.icon}'),
          SizedBox(
            height: 5,
          ),
          Text("${category.name}",
              style: headerTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
