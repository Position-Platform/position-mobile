import 'package:drift/drift.dart';
import 'package:position/src/core/app/db/setting.converter.dart';

class SettingTable extends Table {
  // La méthode get id définit une colonne entière auto-incrémentée qui sert de clé primaire pour la table.
  IntColumn get id => integer().autoIncrement()();

  TextColumn get setting => text().map(const SettingConverter()).nullable()();
}
