// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/map/widgets/positionCategoriesChips.dart';

class PositionCategoriesWidget extends StatefulWidget {
  const PositionCategoriesWidget({
    super.key,
    required this.categories,
    required this.categoryClick,
  });
  final List<Category> categories;
  final Function(Category category) categoryClick;

  @override
  State<PositionCategoriesWidget> createState() =>
      _PositionCategoriesWidgetState();
}

class _PositionCategoriesWidgetState extends State<PositionCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
        child: Row(
          children: [
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children:
                  buildCategories(widget.categories, widget.categoryClick),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildCategories(
      List<Category> categories, Function(Category category) categoryClick) {
    List<Widget> items = [];
    for (var i = 0; i < categories.length; i++) {
      Widget item = PositionCategorieChips(
        label: categories[i].shortname!,
        icon: categories[i].logourl!,
        callback: () {
          categoryClick(categories[i]);
        },
      );
      items.add(item);
    }
    return items;
  }
}
