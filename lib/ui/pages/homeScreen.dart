import 'dart:convert';
import 'dart:io';

import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/category_product_providers.dart';
import 'package:freshmarket/providers/category_providers.dart';
import 'package:freshmarket/providers/classify_provider.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/providers/product_providers.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/ui/Widget/Voucher/voucher_list.dart';
import 'package:freshmarket/ui/Widget/loading/loading_singlebox.dart';
import 'package:freshmarket/ui/Widget/picker/picker_image.dart';
import 'package:freshmarket/ui/Widget/voucher_list/voucher_list.dart';
import 'package:freshmarket/ui/Widget/category/category_list.dart';
import 'package:freshmarket/ui/Widget/category_product/category_product_item.dart';
import 'package:freshmarket/ui/Widget/loading/loading_listview.dart';
import 'package:freshmarket/ui/Widget/loading/loading_typeHorizontal.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// Image result from picker image
  File? image;

  /// Pick some pictures
  /// and scan the images
  void choosePicture() async {
    final classifyProv = Provider.of<ClassifyProvider>(context, listen: false);

    /// Take picture just only availble on idle and complete state
    if (classifyProv.scanState == ClassifyState.Idle ||
        classifyProv.scanState == ClassifyState.Complete) {
      await PickerImage.pick(context, (_image) {
        setState(() {
          image = _image;
        });
        classifyProv.scan(context, _image);
      });
    }
  }

  ScrollController _scrollController = ScrollController();
  String? name;

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
    getInit();
    _loadUserData();
    _initScroll();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    print(localStorage.getString('token')!);
    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  getInit() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<Placemark> cityName;

      cityName =
          Provider.of<MapProvider>(context, listen: false).locationDetail;
      await Provider.of<AddressProvider>(context, listen: false)
          .CheckCity(cityName[0].subAdministrativeArea);

      print('widget ${cityName[0].subAdministrativeArea}');
    });
  }

  Future<void> refreshHome(BuildContext context) async {
    //clear
    final categoryProv = CategoryProvider.instance(context);
    final addressProv = AddressProvider.instance(context);
    final categoryProductProv = CategoryProductProviders.instance(context);
    final voucherProv = VoucherProvider.instance(context);

    addressProv.clearAddress();
    categoryProductProv.clearCategories();
    categoryProv.clearCategories();
    voucherProv.clearVouchers();
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
        ),
        color: _animationBackground.value,
        child: Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: _animationInput.value,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextField(
                  onTap: () {
                    navigate.pushTo('/search-product');
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
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
            SizedBox(width: 13),
            IconButton(
              icon: Icon(Icons.camera_alt, color: _animationIcon.value),
              onPressed: () {
                choosePicture();
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    VoucherProvider voucherProvider = Provider.of<VoucherProvider>(context);
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    MapProvider mapProv = Provider.of<MapProvider>(context);
    CategoryProductProviders categoryProductProvider =
        Provider.of<CategoryProductProviders>(context);

    if (ClassifyProvider.instance(context).scanState ==
        ClassifyState.Scanning) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Menganalisa gambar")
        ],
      );
    }

    if (voucherProvider.myVouchers == null && !voucherProvider.onSearch) {
      voucherProvider.getMyVoucher();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => refreshHome(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                          colors: [primaryColor, primaryColor],
                        ),
                      ),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: _appBarPaddingTop + 50,
                            bottom: _appBarPaddingBottom,
                            right: 15,
                            left: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_pin,
                                      color: Colors.white, size: 18),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  MyAddress(
                                    mapProv: mapProv,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            right: BorderSide(color: neutral30),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/freshcoin.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              children: [
                                                Text('Freshcoin',
                                                    style: subtitleTextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                SizedBox(height: 5),
                                                Text('0 Koin',
                                                    style: primaryTextStyle
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      child: GestureDetector(
                                        onTap: (() {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.92,
                                                color: Colors.white,
                                                child: VoucherButtomSheet(
                                                    isMyVoucher: false)),
                                          );
                                        }),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              right:
                                                  BorderSide(color: neutral30),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/ticket_icon.png',
                                                width: 25,
                                                height: 25,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Column(
                                                children: [
                                                  Text('Voucher',
                                                      style: subtitleTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                  SizedBox(height: 5),
                                                  Text(
                                                      '${voucherProvider.myVouchers?.length} Aktif',
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            right: BorderSide(color: neutral30),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/member.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              children: [
                                                Text('Langganan',
                                                    style: subtitleTextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                SizedBox(height: 5),
                                                Text('0 Koin',
                                                    style: primaryTextStyle
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  addressProvider.onSearch == true
                      ? Center(child: CircularProgressIndicator())
                      : addressProvider.isAvailable == true
                          ? Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(120),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kategori",
                                    style: headerTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _CategoryListWidget(),

                                  SizedBox(
                                    height: 45,
                                  ),

                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Belanja makin hemat 🥳  ",
                                              style: headerTextStyle.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: widthDevice * 0.8,
                                            child: Text(
                                                "Dapatkan diskon dan harga spesial di freshmarket sekarang sebelum kehabisan",
                                                style: subtitleTextStyle
                                                    .copyWith(height: 1.6))),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            height: 200,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    navigate.pushTo('/recipe');
                                                  },
                                                  child: Container(
                                                    width: widthDevice * .9,
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: Image.asset(
                                                            'assets/images/banner_3.jpg')),
                                                  ),
                                                ),
                                                Container(
                                                  width: widthDevice * .9,
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: Image.asset(
                                                          'assets/images/banner_1.jpg')),
                                                ),
                                                Container(
                                                  width: widthDevice * .9,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: Image.asset(
                                                          'assets/images/banner_2.jpg')),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.92,
                                            color: Colors.white,
                                            child: VoucherButtomSheet(
                                                isMyVoucher: false)),
                                      );
                                    }),
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              color: primaryColor,
                                              child: Icon(
                                                Icons.discount_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Ada 3 voucher baru",
                                                    style: headerTextStyle
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                Text("Let's Check Now",
                                                    style: subtitleTextStyle
                                                        .copyWith(
                                                            height: 1.6,
                                                            fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  _CategoryProductListWidget(),
                                  Container(
                                    height: 1200,
                                  )
                                  // Container(
                                  //   width: double.infinity,
                                  //   height: 112,
                                  //   child: ListView(
                                  //       scrollDirection: Axis.horizontal,
                                  //       children: categoryProvider
                                  //           .getCategory()
                                  //           .map((category) => CategoryBox(
                                  //                 category: category,
                                  //               ))
                                  //           .toList()),
                                  // ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 11),
                                decoration: BoxDecoration(
                                    color: alertColorSurface,
                                    borderRadius: BorderRadius.circular(11),
                                    border: Border.all(
                                      color: neutral30,
                                    )),
                                child: Text(
                                    "Opps,Sepertinya layanan kami belum tersedia di lokasi kamu :("),
                              ),
                            )
                ],
              ),
            ),
            _appbar,
          ],
        ),
      ),
    );
  }
}

class MyAddress extends StatelessWidget {
  final MapProvider? mapProv;
  const MyAddress({Key? key, required MapProvider this.mapProv})
      : super(key: key);

  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, addressProv, _) {
      print('ini state address list ${addressProv.listAddress}');
      if (addressProv.listAddress == null && !addressProv.onSearch) {
        addressProv.getListAddress();
        addressProv.getSelectedAddress();
        return const Text("loadingggg");
      }
      if (addressProv.listAddress == null && addressProv.onSearch) {
        return const Text("loadingggg");
      }
      if (!addressProv.listAddress!.isEmpty) {
        return Row(
          children: [
            Text('Dikirim ke  ',
                style: subtitleTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400)),
            Text(addressProv.selectedAddress?.label ?? '',
                style: subtitleTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            SizedBox(width: 3),
            Icon(Icons.arrow_drop_down, color: Colors.white, size: 18)
          ],
        );
      }
      return GestureDetector(
        onTap: () {
          navigate.pushTo('/search-location');
        },
        child: Text(
            "dikirim ke  ${mapProv?.complateAddress?.substring(0, 25)}... ",
            overflow: TextOverflow.ellipsis,
            style: subtitleTextStyle.copyWith(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400)),
      );
    });
  }
}

class _CategoryListWidget extends StatelessWidget {
  _CategoryListWidget();
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, categoryProv, _) {
      if (categoryProv.categories == null) {
        categoryProv.getCategory();
        return const LoadingTypeHorizontal();
      }
      if (categoryProv.categories!.isEmpty) {
        return Text('Ups data cetegory kosong');
      }

      return CategoryListWidget(categories: categoryProv.categories!);
    });
  }
}

class _CategoryProductListWidget extends StatelessWidget {
  const _CategoryProductListWidget();
  Widget build(BuildContext context) {
    MapProvider mapProv = Provider.of<MapProvider>(context);
    return Consumer<CategoryProductProviders>(
        builder: (context, categoryProductProv, _) {
      if (categoryProductProv.categoriesProduct == null) {
        categoryProductProv.getCategoriesProduct(
            mapProv.locationDetail[0].subAdministrativeArea);
        return const LoadingTypeHorizontal();
      }
      if (categoryProductProv.categoriesProduct!.isEmpty) {
        return Text('Ups data cetegory kosong');
      }

      return CategoryProductItem(
          categoryProduct: categoryProductProv.categoriesProduct!);
    });
  }
}
