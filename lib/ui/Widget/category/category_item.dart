import 'package:flutter/material.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/categoryProductScreen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);
  final CategoryModels category;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return InkWell(
      
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProduct(
                      id: category.id,
                    )));
      },
    
        child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 73,
                height: 73,
                decoration: BoxDecoration(
                    color: Color(0xffF3F5F7),
                    borderRadius: BorderRadius.circular(100)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('$baseUrl/icon/${category.icon}',width: 35,height: 35,),
                   
                 
                  ],
                ),
              ),
              SizedBox(height: 5),
                 Text("${category.name}",
                style: headerTextStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
    
    );
  }
}
