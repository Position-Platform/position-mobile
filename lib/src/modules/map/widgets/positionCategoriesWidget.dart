// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/map/widgets/positionCategoriesChips.dart';

class PositionCategoriesWidget extends StatelessWidget {
  const PositionCategoriesWidget({
    super.key,
    required this.categories,
    required this.categoryClick,
  });

  final List<Category> categories;
  final Function(Category category) categoryClick;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics:
          const BouncingScrollPhysics(), // Comportement de défilement plus fluide
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            // Rendre la liste de puces plus efficace avec une ListView.builder
            categories.isEmpty
                ? const SizedBox
                    .shrink() // Éviter de construire quoi que ce soit si la liste est vide
                : Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: _buildCategoryChips(),
                  ),
          ],
        ),
      ),
    );
  }

  // Optimisé pour éviter la création inutile de widgets
  List<Widget> _buildCategoryChips() {
    return List.generate(
      categories.length,
      (index) {
        final category = categories[index];
        return PositionCategorieChips(
          key: ValueKey(
              'category_${category.id}'), // Ajouter une clé pour aider le framework à identifier les widgets
          label: category.shortname ?? '',
          icon: category.logourl ?? '',
          callback: () => categoryClick(category),
        );
      },
    );
  }
}
