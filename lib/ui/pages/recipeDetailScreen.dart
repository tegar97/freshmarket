import 'package:flutter/material.dart';
import 'package:freshmarket/models/recipeModels.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/recipeProviders.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/data/setting/url.dart';
import 'package:freshmarket/data/setting/url.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({Key? key, this.recipe}) : super(key: key);
  final Recipe? recipe;
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  String? menu = 'Detail';

  @override
  Widget build(BuildContext context) {
    Future<void> showSuccessDialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) => Container(
                width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                child: AlertDialog(
                  backgroundColor: lightModeBgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.close,
                            color: primaryColor,
                          ),
                        ),
                        Image.asset(
                          'assets/images/success.png',
                          width: 100,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('Hurray :)',
                            style: primaryTextStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          'Bahan bahan yang dibutuhkan sudah dimasukan ke keranjang',
                          style: subtitleTextStyle.copyWith(fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 154,
                          height: 44,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                              child: Text('Lihat keranjang',
                                  style: primaryTextStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ));
    }

    double widthDevice = MediaQuery.of(context).size.width;
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: menu == 'Bahan'
            ? FloatingActionButton.extended(
                onPressed: () {
                  for (var item in widget.recipe!.recipeItem!) {
                    cartProvider.addCart(item.product, item.qty);
                  }
                  showSuccessDialog();
                },
                label: Text('Beli bahan bahan'),
                backgroundColor: primaryColor,
              )
            : null,
      ),
      appBar: AppBar(
        backgroundColor: lightModeBgColor,
        elevation: 0.5,
        title: Text("Resep ",
            style: headerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        children: [
          Text("${widget.recipe!.title}",
              style: headerTextStyle.copyWith(
                  fontSize: 22, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  '${baseUrl}/recipe/${widget.recipe!.image}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    menu = 'Detail';
                  });
                },
                child: Container(
                  width: (widthDevice * 0.5) - 16,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Center(
                      child: Text("Detail",
                          style: menu == "Detail"
                              ? headerTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)
                              : null)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: menu == "Detail" ? primaryColor : neutral30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    menu = 'Bahan';
                  });
                },
                child: Container(
                  width: (widthDevice * 0.5) - 16,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: menu == "Bahan" ? primaryColor : neutral30,
                  ),
                  child: Center(
                      child: Text("Bahan",
                          style: menu == "Bahan"
                              ? headerTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)
                              : null)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          menu == "Detail"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deskripsi",
                        style: headerTextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${widget.recipe!.description}",
                        style: subtitleTextStyle2.copyWith(fontSize: 13)),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Step",
                        style: headerTextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${widget.recipe!.step} ",
                        style: subtitleTextStyle2.copyWith(fontSize: 13))
                  ],
                )
              : Column(
                  children: widget.recipe!.recipeItem!
                      .map((item) =>
                          igredientBox(widthDevice: widthDevice, item: item))
                      .toList())
        ],
      ),
    );
  }
}

class igredientBox extends StatelessWidget {
  const igredientBox({Key? key, required this.widthDevice, this.item})
      : super(key: key);

  final double widthDevice;
  final RecipeItem? item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthDevice - 36,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: neutral30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(right: 2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Image.network(
              '${baseUrl}/product/${item!.product!.image}',
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text("${item!.product!.name}",
                  style: headerTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600))),
          Text("x${item!.qty}")
        ],
      ),
    );
  }
}
