import 'dart:convert';

import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/category_product_providers.dart';
import 'package:freshmarket/providers/category_providers.dart';
import 'package:freshmarket/providers/classify_provider.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/ui/Widget/Voucher/voucher_list.dart';
import 'package:freshmarket/ui/Widget/product/product_item.dart';
import 'package:freshmarket/ui/Widget/voucher_list/voucher_list.dart';
import 'package:freshmarket/ui/Widget/category/category_list.dart';
import 'package:freshmarket/ui/Widget/category_product/category_product_item.dart';
import 'package:freshmarket/ui/Widget/loading/loading_listview.dart';
import 'package:freshmarket/ui/Widget/loading/loading_typeHorizontal.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/categoryProductScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/helper/convertRupiah.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  String? name;
  var searchController = TextEditingController();

  late CurvedAnimationController<Color> _animationBackground;
  late CurvedAnimationController<Color> _animationInput;
  late CurvedAnimationController<Color> _animationIcon;

  double get _systemBarHeight => MediaQuery.of(context).padding.top;
  double get _appBarHeight => kToolbarHeight + _systemBarHeight;
  double get _appBarPaddingVertical => 10;
  double get _appBarPaddingTop => _systemBarHeight + _appBarPaddingVertical;
  double get _appBarPaddingBottom => _appBarPaddingVertical;

  Color _appbarBackgroundColorBegin = Colors.white.withOpacity(0.0);
  Color _appbarBackgroundColorEnd = Colors.white;

  Color _inputBackgroundColorBegin = Colors.white.withOpacity(0.92);
  Color _inputBackgroundColorEnd = Color(0xFFEFEFEF);

  Color _iconColorBegin = Colors.white.withOpacity(0.92);
  Color _iconColorEnd = Colors.grey;

  @override
  void initState() {
    _initAnimation();
    super.initState();
    _loadClassiyData();
    _initScroll();
  }

  // _loadUserData() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var user = jsonDecode(localStorage.getString('user')!);
  //   print(localStorage.getString('token')!);
  //   if (user != null) {
  //     setState(() {
  //       name = user['name'];
  //     });
  //   }

  // }

  _loadClassiyData() {
    final classiyProv = ClassifyProvider.instance(context);
    print(classiyProv.scanState);
    if (classiyProv.productResult != null &&
        classiyProv.scanState == ClassifyState.Complete) {
      ProductProvider.instance(context)
          .search(classiyProv.productResult?.substring(2) ?? '');
    } 
  }

  Future<void> refreshHome(BuildContext context) async {
    //clear
    final categoryProv = CategoryProvider.instance(context);
    final categoryProductProv = CategoryProductProviders.instance(context);

    categoryProductProv.clearCategories();
    categoryProv.clearCategories();
    final prefs = await SharedPreferences.getInstance();
  }

  _initAnimation() {
    _animationBackground = CurvedAnimationController<Color>.tween(
      ColorTween(
          begin: _appbarBackgroundColorBegin, end: _appbarBackgroundColorEnd),
      Duration(milliseconds: 300),
      curve: Curves.ease,
      vsync: this,
    );

    _animationInput = CurvedAnimationController<Color>.tween(
      ColorTween(
          begin: _inputBackgroundColorBegin, end: _inputBackgroundColorEnd),
      Duration(milliseconds: 300),
      curve: Curves.ease,
      vsync: this,
    );

    _animationIcon = CurvedAnimationController<Color>.tween(
      ColorTween(begin: _iconColorBegin, end: _iconColorEnd),
      Duration(milliseconds: 300),
      curve: Curves.ease,
      vsync: this,
    );

    _animationBackground.addListener(() => setState(() {}));
    _animationInput.addListener(() => setState(() {}));
    _animationIcon.addListener(() => setState(() {}));
  }

  //Animation Scroll setting
  _initScroll() {
    _scrollController.addListener(() {
      double startAnimationAfterOffset = 75;
      double scrollOffsetBackground = 120;
      double scrollOffsetInput = 150;
      double scrollOffsetIcon = 120;

      // delay animation to start animate only after scrolling
      // as far as startAnimationAfterOffset value
      // this is for a smoother effect
      double offset = _scrollController.offset - startAnimationAfterOffset;
      double progressBackground = offset / scrollOffsetBackground;
      double progressInput = offset / scrollOffsetInput;
      double progressIcon = offset / scrollOffsetIcon;

      // make sure progress animation always between 0.0 and 1.0
      progressBackground = progressBackground <= 0.0 ? 0.0 : progressBackground;
      progressBackground = progressBackground >= 1.0 ? 1.0 : progressBackground;

      // make sure progress animation always between 0.0 and 1.0
      progressInput = progressInput <= 0.0 ? 0.0 : progressInput;
      progressInput = progressInput >= 1.0 ? 1.0 : progressInput;

      // make sure progress animation always between 0.0 and 1.0
      progressIcon = progressIcon <= 0.0 ? 0.0 : progressIcon;
      progressIcon = progressIcon >= 1.0 ? 1.0 : progressIcon;

      _animationBackground.progress = progressBackground;
      _animationInput.progress = progressInput;
      _animationIcon.progress = progressIcon;
    });
  }

  Widget get _appbar => Container(
        height: _appBarHeight,
        padding: EdgeInsets.only(
          top: _appBarPaddingTop,
          bottom: _appBarPaddingBottom,
          right: 15,
          left: 15,
        ),
        color: _animationBackground.value,
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ProductProvider.instance(context).clearSearch();
                  ClassifyProvider.instance(context).clearResult();
                },
                child: Icon(Icons.arrow_back_ios, color: neutral90)),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: _animationInput.value,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: searchController,
                  onChanged: (value) {
                    Duration(seconds: 1);
                    ProductProvider.instance(context).search(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Color(0xffEDEDED),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    CategoryProductProviders categoryProductProvider =
        Provider.of<CategoryProductProviders>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartProvider.carts.length > 0
          ? Container(
              width: double.infinity,
              height: 70,
              child: FloatingActionButton.extended(
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => refreshHome(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: _appBarPaddingTop + 80,
                bottom: _appBarPaddingBottom,
                right: 15,
                left: 15,
              ),
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_ProductSearchProduct()],
              ),
            ),
            _appbar
          ],
        ),
      ),
    );
  }
}

class _ProductSearchProduct extends StatelessWidget {
  const _ProductSearchProduct();
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Consumer<ProductProvider>(builder: (context, productProv, _) {
    if (ClassifyProvider.instance(context).errorMessage != null &&
          ClassifyProvider.instance(context).scanState == 
              ClassifyState.Complete && !productProv.onSearch && productProv.searchProducts == null)  {
        return Text("Upss sepertinya product yang dicari tidak tersedia");
      }  
      if (productProv.searchProducts == null && !productProv.onSearch) {
        return Text("Cari Produk");
      }

      if (productProv.searchProducts == null && productProv.onSearch) {
        return const LoadingListView();
      }

      if (productProv.searchProducts!.isEmpty) {
        return Text("Produk tidak ditemukan");
      }

      

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ClassifyProvider.instance(context).productResult != null
          //     ? Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text(
          //             ' ${ClassifyProvider.instance(context).productResult?.substring(2)}'),
          //       ],
          //     )
          //     : Text(""),
          _searchResultWidget(productProv.searchProducts!.length),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // banyak grid yang ditampilkan dalam satu baris
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              childAspectRatio: 0.62,
            ),
            itemCount: productProv.searchProducts!.length,
            itemBuilder: (context, index) {
              return ProductCategoryContainer(
                widthDevice: widthDevice,
                cartProvider: cartProvider,
                product: productProv.searchProducts![index],
              );
            },
          ),
        ],
      );
    });
  }

  Widget _searchResultWidget(int total) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: Row(
        children: [
        
          Text(
            "$total  Produk ditemukan ",
            style: subtitleTextStyle.copyWith(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
