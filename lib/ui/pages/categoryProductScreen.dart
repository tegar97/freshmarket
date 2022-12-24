import 'package:flutter/material.dart';
import 'package:freshmarket/models/productModels.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/ui/global/widget/skeleton.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/checkoutScreen.dart';
import 'package:freshmarket/ui/pages/homeScreen.dart';
import 'package:freshmarket/ui/pages/productDetailScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({Key? key, this.id, this.city_name}) : super(key: key);
  final int? id;
  final String? city_name;
  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  void initState() {
    super.initState();

    getInit();
  }

  Future<void> getInit() async {
    List<Placemark> cityName;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      cityName =
          Provider.of<MapProvider>(context, listen: false).locationDetail;
      await Provider.of<ProductProvider>(context, listen: false)
          .getProduct(categoryId: widget.id, cityName: cityName[0].subAdministrativeArea);
      print('widget ${cityName[0].subAdministrativeArea}');
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    MapProvider mapProv = Provider.of<MapProvider>(context);
    double widthDevice = MediaQuery.of(context).size.width;
    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 2),
      () => 'Data Loaded',
    );
    if (mapProv.locationDetail[0].subAdministrativeArea == null) {
      mapProv.initLocation();
      productProvider.getProduct(
          categoryId: widget.id,
          cityName: mapProv.locationDetail[0].subAdministrativeArea);
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        backgroundColor: lightModeBgColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: cartProvider.carts.length > 0
            ? Container(
                width: double.infinity,
                height: 70,
                child: FloatingActionButton.extended(
                  shape:
                      BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                  onPressed: () {},
                  label: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: widthDevice * 0.4,
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: cartProvider.carts
                              .map((cart) => Column(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(right: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Image.network(
                                          '$baseUrl/product/${cart!.product!.image}',
                                          width: 20,
                                          height: 20,
                                        ),
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        width: widthDevice * 0.19,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Row(
                          children: [
                            Text(
                              "${CurrencyFormat.convertToIdr(cartProvider.totalPrice(), 0)}",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: primaryColor,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: primaryColor,
                ),
              )
            : null,
        appBar: AppBar(
          title: Text("Product",
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
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: FutureBuilder(
                future: _calculation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.62,
                        children: productProvider.product!
                            .map((product) => GestureDetector(
                                onTap: () {},
                                child: ProductCategoryContainer(
                                    widthDevice: widthDevice,
                                    product: product,
                                    cartProvider: cartProvider)))
                            .toList());
                  } else {
                    return GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.62,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(4, (index) {
                        return Container(
                            child: Skeleton(),
                            margin: EdgeInsets.only(right: 10));
                      }),
                    );
                  }
                },
              )),
        ),
      );
    }
  }
}

class ProductCategoryContainer extends StatelessWidget {
  const ProductCategoryContainer(
      {Key? key,
      required this.widthDevice,
      required this.product,
      required this.cartProvider})
      : super(key: key);

  final double widthDevice;
  final ProductModels product;
  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                            product: product,
                          )));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Column(
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text("/ kg",
                                    style: subtitleTextStyle.copyWith(
                                        fontSize: 12))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                primary: Colors.white,
                minimumSize: Size(double.infinity, 40),
              ),
              onPressed: () {
                cartProvider.addCart(product, 1);
              },
              child: Text("Beli"))
        ],
      ),
    );
  }
}
