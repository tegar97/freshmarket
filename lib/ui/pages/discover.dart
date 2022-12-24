import 'package:flutter/material.dart';
import 'package:freshmarket/models/recipeModels.dart';
import 'package:freshmarket/providers/recipeProviders.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/recipeDetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/data/setting/url.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    RecipeProvider recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: AppBar(
        title: Text("Resep rahasia",
            style: headerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
                elevation: 0.5,

        backgroundColor: lightModeBgColor,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temukan resep lezat disini 🤤",
                  style: headerTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: widthDevice - 32,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: neutral60,
                          ),

                          fillColor: neutral20,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: neutral20, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide:
                                BorderSide(color: neutral20, width: 1.5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffEDEDED), width: 1.5),
                          ),
                          focusColor: Colors.red,
                          labelStyle: TextStyle(color: primaryColor),
                          hintText: "Resep Nasi goreng kampung..",

                          contentPadding: EdgeInsets.all(18), // Added this
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: recipeProvider.recipe
                      .map((recipe) => RecipeBox(recipe: recipe))
                      .toList(),
                )
              ],
            ),
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}

class RecipeBox extends StatelessWidget {
  const RecipeBox({
    Key? key,
    this.recipe,
  }) : super(key: key);
  final Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                      recipe: recipe,
                    )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        margin : EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(
              '$baseUrl/recipe/${recipe!.image}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/calori_icon.png',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("${recipe!.calori}",
                                  style: headerTextStyle.copyWith(
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${recipe!.title}",
                        style: headerTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text("${recipe!.estimateTime} Menit",
                              style: headerTextStyle.copyWith(
                                  color: Colors.white, fontSize: 13))
                        ],
                      )
                    ],
                  )
              ],
              ),
            )),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffEAF3DE),
            ),
            child: Image.asset('assets/images/category_1.png',
                width: 20, height: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text("Vegetable", style: subtitleTextStyle.copyWith(fontSize: 13))
        ],
      ),
    );
  }
}
