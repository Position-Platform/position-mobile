// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $SettingTableTable extends SettingTable
    with TableInfo<$SettingTableTable, SettingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _settingMeta =
      const VerificationMeta('setting');
  @override
  late final GeneratedColumnWithTypeConverter<Setting?, String> setting =
      GeneratedColumn<String>('setting', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Setting?>($SettingTableTable.$convertersettingn);
  @override
  List<GeneratedColumn> get $columns => [id, setting];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setting_table';
  @override
  VerificationContext validateIntegrity(Insertable<SettingTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_settingMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      setting: $SettingTableTable.$convertersettingn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}setting'])),
    );
  }

  @override
  $SettingTableTable createAlias(String alias) {
    return $SettingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Setting, String> $convertersetting =
      const SettingConverter();
  static TypeConverter<Setting?, String?> $convertersettingn =
      NullAwareTypeConverter.wrap($convertersetting);
}

class SettingTableData extends DataClass
    implements Insertable<SettingTableData> {
  final int id;
  final Setting? setting;
  const SettingTableData({required this.id, this.setting});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || setting != null) {
      map['setting'] = Variable<String>(
          $SettingTableTable.$convertersettingn.toSql(setting));
    }
    return map;
  }

  SettingTableCompanion toCompanion(bool nullToAbsent) {
    return SettingTableCompanion(
      id: Value(id),
      setting: setting == null && nullToAbsent
          ? const Value.absent()
          : Value(setting),
    );
  }

  factory SettingTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingTableData(
      id: serializer.fromJson<int>(json['id']),
      setting: serializer.fromJson<Setting?>(json['setting']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'setting': serializer.toJson<Setting?>(setting),
    };
  }

  SettingTableData copyWith(
          {int? id, Value<Setting?> setting = const Value.absent()}) =>
      SettingTableData(
        id: id ?? this.id,
        setting: setting.present ? setting.value : this.setting,
      );
  @override
  String toString() {
    return (StringBuffer('SettingTableData(')
          ..write('id: $id, ')
          ..write('setting: $setting')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, setting);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingTableData &&
          other.id == this.id &&
          other.setting == this.setting);
}

class SettingTableCompanion extends UpdateCompanion<SettingTableData> {
  final Value<int> id;
  final Value<Setting?> setting;
  const SettingTableCompanion({
    this.id = const Value.absent(),
    this.setting = const Value.absent(),
  });
  SettingTableCompanion.insert({
    this.id = const Value.absent(),
    this.setting = const Value.absent(),
  });
  static Insertable<SettingTableData> custom({
    Expression<int>? id,
    Expression<String>? setting,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (setting != null) 'setting': setting,
    });
  }

  SettingTableCompanion copyWith({Value<int>? id, Value<Setting?>? setting}) {
    return SettingTableCompanion(
      id: id ?? this.id,
      setting: setting ?? this.setting,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (setting.present) {
      map['setting'] = Variable<String>(
          $SettingTableTable.$convertersettingn.toSql(setting.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingTableCompanion(')
          ..write('id: $id, ')
          ..write('setting: $setting')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  _$MyDatabaseManager get managers => _$MyDatabaseManager(this);
  late final $SettingTableTable settingTable = $SettingTableTable(this);
  late final SettingDao settingDao = SettingDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [settingTable];
}

typedef $$SettingTableTableInsertCompanionBuilder = SettingTableCompanion
    Function({
  Value<int> id,
  Value<Setting?> setting,
});
typedef $$SettingTableTableUpdateCompanionBuilder = SettingTableCompanion
    Function({
  Value<int> id,
  Value<Setting?> setting,
});

class $$SettingTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $SettingTableTable,
    SettingTableData,
    $$SettingTableTableFilterComposer,
    $$SettingTableTableOrderingComposer,
    $$SettingTableTableProcessedTableManager,
    $$SettingTableTableInsertCompanionBuilder,
    $$SettingTableTableUpdateCompanionBuilder> {
  $$SettingTableTableTableManager(_$MyDatabase db, $SettingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SettingTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SettingTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SettingTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<Setting?> setting = const Value.absent(),
          }) =>
              SettingTableCompanion(
            id: id,
            setting: setting,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<Setting?> setting = const Value.absent(),
          }) =>
              SettingTableCompanion.insert(
            id: id,
            setting: setting,
          ),
        ));
}

class $$SettingTableTableProcessedTableManager extends ProcessedTableManager<
    _$MyDatabase,
    $SettingTableTable,
    SettingTableData,
    $$SettingTableTableFilterComposer,
    $$SettingTableTableOrderingComposer,
    $$SettingTableTableProcessedTableManager,
    $$SettingTableTableInsertCompanionBuilder,
    $$SettingTableTableUpdateCompanionBuilder> {
  $$SettingTableTableProcessedTableManager(super.$state);
}

class $$SettingTableTableFilterComposer
    extends FilterComposer<_$MyDatabase, $SettingTableTable> {
  $$SettingTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Setting?, Setting, String> get setting =>
      $state.composableBuilder(
          column: $state.table.setting,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$SettingTableTableOrderingComposer
    extends OrderingComposer<_$MyDatabase, $SettingTableTable> {
  $$SettingTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get setting => $state.composableBuilder(
      column: $state.table.setting,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$MyDatabaseManager {
  final _$MyDatabase _db;
  _$MyDatabaseManager(this._db);
  $$SettingTableTableTableManager get settingTable =>
      $$SettingTableTableTableManager(_db, _db.settingTable);
}
