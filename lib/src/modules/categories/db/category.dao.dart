import 'package:drift/drift.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/modules/categories/db/category.table.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';

part 'category.dao.g.dart';

@DriftAccessor(tables: [CategoryTable])
class CategoryDao extends DatabaseAccessor<MyDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);

  // Optimisation: Ajouter un ordre de tri par défaut
  Future<List<CategoryTableData>> get allCategories =>
      (select(categoryTable)..orderBy([(t) => OrderingTerm.desc(t.id)])).get();

  // Ajout d'une méthode pour vérifier si une catégorie existe
  Future<bool> categoryExists(int id) async {
    final count = await (select(categoryTable)..where((t) => t.id.equals(id)))
        .get()
        .then((list) => list.length);
    return count > 0;
  }

  Future<CategoryTableData> getCategory(int id) {
    return (select(categoryTable)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> addCategory(CategoryTableCompanion entry) {
    return into(categoryTable).insert(entry, mode: InsertMode.insertOrReplace);
  }

  // Optimisation: Ajouter une méthode pour insérer ou mettre à jour en masse
  Future<void> upsertCategories(List<CategoryTableCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(categoryTable, entries);
    });
  }

  Future<bool> updateCategory(CategoryTableCompanion entry) {
    return update(categoryTable).replace(entry);
  }

  Future<int> deleteCategory(int id) {
    return (delete(categoryTable)..where((t) => t.id.equals(id))).go();
  }

  // Ajout d'une méthode pour supprimer toutes les catégories
  Future<int> deleteAllCategories() {
    return delete(categoryTable).go();
  }

  // Optimisation: Ajouter une méthode pour récupérer les catégories plus consultées
  Future<List<CategoryTableData>> getMostViewedCategories(int limit) {
    return (customSelect(
      'SELECT * FROM category_table WHERE category LIKE \'%"vues":%\' ORDER BY '
      'CAST(SUBSTR(category, INSTR(category, \'"vues":\')+7, '
      'INSTR(SUBSTR(category, INSTR(category, \'"vues":\')+7), \',\')-1) AS INTEGER) DESC '
      'LIMIT ?',
      variables: [Variable.withInt(limit)],
      readsFrom: {categoryTable},
    ).map((row) {
      return CategoryTableData(
        id: row.read<int>('id'),
        category: row.read<Category>('category'),
      );
    }).get());
  }
}
