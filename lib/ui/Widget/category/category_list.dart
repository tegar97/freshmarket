import 'package:flutter/material.dart';
import 'package:freshmarket/models/categoryModels.dart';
import 'package:freshmarket/ui/Widget/category/category_item.dart';
import 'package:freshmarket/ui/home/theme.dart';

class CategoryListWidget extends StatefulWidget {
  final List<CategoryModels> categories;
  final bool useHero;
  final bool useReplacement;
  const CategoryListWidget({
    Key? key,
    required this.categories,
    this.useHero = true,
    this.useReplacement = false,
  }) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  final _scrollController = ScrollController(initialScrollOffset: 0);
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_scrollListener);
    });
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_scrollPosition);
    return Column(
      children: [
        Container(
          height: 112,
          width: double.infinity,
          child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
                physics: BouncingScrollPhysics(),

              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                CategoryModels category = widget.categories[index];
                return CategoryItem(category: category);
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: double.infinity,
            height: 10,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    left: MediaQuery.of(context).size.width / 2.3,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           color: neutral60.withOpacity(0.4))
                        ),
                        width: 40,
                        height: 10,
                ),
                       
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2.3) +
                        (_scrollPosition / 3),
                    child:
                        Container(
                           decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           color: primaryColor
                        ),
                          width: 20, height: 10))
              ],
            ))
      ],
    );
  }
}
