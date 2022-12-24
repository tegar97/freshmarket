import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryProductModels.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/ui/Widget/product/product_item.dart';
import 'package:freshmarket/ui/home/theme.dart';

import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/ui/pages/categoryProductScreen.dart';
import 'package:provider/provider.dart';

class CategoryProductItem extends StatelessWidget {
  const CategoryProductItem({Key? key, required this.categoryProduct})
      : super(key: key);

  final List<CategoryProductModels> categoryProduct;
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    MapProvider mapProv = Provider.of<MapProvider>(context);
    print(' category ${mapProv.locationDetail[0].subAdministrativeArea}');
    if(mapProv.locationDetail[0].subAdministrativeArea != null){
      
    }
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemCount: categoryProduct.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          CategoryProductModels category = categoryProduct[index];
          return Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "${category.title}",
                                style: headerTextStyle.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoryProduct(
                                                id: category.id,
                                                city_name: mapProv.locationDetail.isEmpty ? '' :  mapProv
                                                    .locationDetail[0]
                                                    .subAdministrativeArea,
                                              )));
                                },
                                child: Text(
                                  "Lihat semua",
                                  style: TextStyle(color: Colors.green),
                                ))
                            // Image.network(
                            //   '$baseUrl/icon/${category.icon}',
                            //   width: 20,
                            //   height: 20,
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: widthDevice - 16,
                          height: 214,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: category.products?.length,
                            itemBuilder: (context, index) {
                              ProductModels product = category.products![index];
                              return ProductItem(
                                  widthDevice: widthDevice, product: product);
                            },
                          ),
                        )
                      ])));
        }));
  }
}
