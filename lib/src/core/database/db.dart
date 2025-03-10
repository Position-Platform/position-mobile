import 'dart:io';

import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:position/src/modules/auth/db/setting/setting.converter.dart';
import 'package:position/src/modules/auth/db/setting/setting.dao.dart';
import 'package:position/src/modules/auth/db/setting/setting.table.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/auth/db/user/user.converter.dart';
import 'package:position/src/modules/auth/db/user/user.dao.dart';
import 'package:position/src/modules/auth/db/user/user.table.dart';
import 'package:position/src/modules/auth/models/user_model/user.dart';
import 'package:position/src/modules/categories/db/category.converter.dart';
import 'package:position/src/modules/categories/db/category.dao.dart';
import 'package:position/src/modules/categories/db/category.table.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'db.g.dart';

// Annotation pour indiquer que cette classe est une base de données Drift
@DriftDatabase(
    tables: [SettingTable, UserTable, CategoryTable],
    daos: [SettingDao, UserDao, CategoryDao])
class MyDatabase extends _$MyDatabase {
  // Constructeur pour spécifier l'emplacement de la base de données
  MyDatabase() : super(_openConnection());

  // Numéro de version du schéma de la base de données
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'position.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
