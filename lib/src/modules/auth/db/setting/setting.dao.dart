import 'package:drift/drift.dart';
import 'package:position/src/modules/auth/db/setting/setting.table.dart';
import 'package:position/src/core/database/db.dart';

part 'setting.dao.g.dart';

@DriftAccessor(tables: [SettingTable])
class SettingDao extends DatabaseAccessor<MyDatabase> with _$SettingDaoMixin {
  // Ce constructeur est requis pour que la base de données principale puisse créer une instance de cet objet.
  SettingDao(super.db);

  Future<SettingTableData?> getSetting() {
    return (select(settingTable)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
  }

  Future<int> addSetting(SettingTableCompanion entry) {
    return into(settingTable).insert(entry);
  }

  Future updateSetting(SettingTableCompanion entry) {
    return update(settingTable).replace(entry);
  }
}
