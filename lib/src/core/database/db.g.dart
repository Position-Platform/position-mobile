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
  SettingTableData copyWithCompanion(SettingTableCompanion data) {
    return SettingTableData(
      id: data.id.present ? data.id.value : this.id,
      setting: data.setting.present ? data.setting.value : this.setting,
    );
  }

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

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<User?, String> user =
      GeneratedColumn<String>('user', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<User?>($UserTableTable.$converterusern);
  @override
  List<GeneratedColumn> get $columns => [id, user];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user: $UserTableTable.$converterusern.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user'])),
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }

  static TypeConverter<User, String> $converteruser = const UserConverter();
  static TypeConverter<User?, String?> $converterusern =
      NullAwareTypeConverter.wrap($converteruser);
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final int id;
  final User? user;
  const UserTableData({required this.id, this.user});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || user != null) {
      map['user'] =
          Variable<String>($UserTableTable.$converterusern.toSql(user));
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      user: user == null && nullToAbsent ? const Value.absent() : Value(user),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<User?>(json['user']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<User?>(user),
    };
  }

  UserTableData copyWith({int? id, Value<User?> user = const Value.absent()}) =>
      UserTableData(
        id: id ?? this.id,
        user: user.present ? user.value : this.user,
      );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      user: data.user.present ? data.user.value : this.user,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.user == this.user);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<User?> user;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
  });
  static Insertable<UserTableData> custom({
    Expression<int>? id,
    Expression<String>? user,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
    });
  }

  UserTableCompanion copyWith({Value<int>? id, Value<User?>? user}) {
    return UserTableCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] =
          Variable<String>($UserTableTable.$converterusern.toSql(user.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<Category?, String> category =
      GeneratedColumn<String>('category', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Category?>($CategoryTableTable.$convertercategoryn);
  @override
  List<GeneratedColumn> get $columns => [id, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: $CategoryTableTable.$convertercategoryn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])),
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Category, String> $convertercategory =
      const CategoryConverter();
  static TypeConverter<Category?, String?> $convertercategoryn =
      NullAwareTypeConverter.wrap($convertercategory);
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final int id;
  final Category? category;
  const CategoryTableData({required this.id, this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(
          $CategoryTableTable.$convertercategoryn.toSql(category));
    }
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<Category?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<Category?>(category),
    };
  }

  CategoryTableData copyWith(
          {int? id, Value<Category?> category = const Value.absent()}) =>
      CategoryTableData(
        id: id ?? this.id,
        category: category.present ? category.value : this.category,
      );
  CategoryTableData copyWithCompanion(CategoryTableCompanion data) {
    return CategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.id == this.id &&
          other.category == this.category);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<int> id;
  final Value<Category?> category;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  static Insertable<CategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<int>? id, Value<Category?>? category}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
          $CategoryTableTable.$convertercategoryn.toSql(category.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  $MyDatabaseManager get managers => $MyDatabaseManager(this);
  late final $SettingTableTable settingTable = $SettingTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final SettingDao settingDao = SettingDao(this as MyDatabase);
  late final UserDao userDao = UserDao(this as MyDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [settingTable, userTable, categoryTable];
}

typedef $$SettingTableTableCreateCompanionBuilder = SettingTableCompanion
    Function({
  Value<int> id,
  Value<Setting?> setting,
});
typedef $$SettingTableTableUpdateCompanionBuilder = SettingTableCompanion
    Function({
  Value<int> id,
  Value<Setting?> setting,
});

class $$SettingTableTableFilterComposer
    extends Composer<_$MyDatabase, $SettingTableTable> {
  $$SettingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Setting?, Setting, String> get setting =>
      $composableBuilder(
          column: $table.setting,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$SettingTableTableOrderingComposer
    extends Composer<_$MyDatabase, $SettingTableTable> {
  $$SettingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setting => $composableBuilder(
      column: $table.setting, builder: (column) => ColumnOrderings(column));
}

class $$SettingTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $SettingTableTable> {
  $$SettingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Setting?, String> get setting =>
      $composableBuilder(column: $table.setting, builder: (column) => column);
}

class $$SettingTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $SettingTableTable,
    SettingTableData,
    $$SettingTableTableFilterComposer,
    $$SettingTableTableOrderingComposer,
    $$SettingTableTableAnnotationComposer,
    $$SettingTableTableCreateCompanionBuilder,
    $$SettingTableTableUpdateCompanionBuilder,
    (
      SettingTableData,
      BaseReferences<_$MyDatabase, $SettingTableTable, SettingTableData>
    ),
    SettingTableData,
    PrefetchHooks Function()> {
  $$SettingTableTableTableManager(_$MyDatabase db, $SettingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<Setting?> setting = const Value.absent(),
          }) =>
              SettingTableCompanion(
            id: id,
            setting: setting,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<Setting?> setting = const Value.absent(),
          }) =>
              SettingTableCompanion.insert(
            id: id,
            setting: setting,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $SettingTableTable,
    SettingTableData,
    $$SettingTableTableFilterComposer,
    $$SettingTableTableOrderingComposer,
    $$SettingTableTableAnnotationComposer,
    $$SettingTableTableCreateCompanionBuilder,
    $$SettingTableTableUpdateCompanionBuilder,
    (
      SettingTableData,
      BaseReferences<_$MyDatabase, $SettingTableTable, SettingTableData>
    ),
    SettingTableData,
    PrefetchHooks Function()>;
typedef $$UserTableTableCreateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<User?> user,
});
typedef $$UserTableTableUpdateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<User?> user,
});

class $$UserTableTableFilterComposer
    extends Composer<_$MyDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<User?, User, String> get user =>
      $composableBuilder(
          column: $table.user,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$UserTableTableOrderingComposer
    extends Composer<_$MyDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get user => $composableBuilder(
      column: $table.user, builder: (column) => ColumnOrderings(column));
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<User?, String> get user =>
      $composableBuilder(column: $table.user, builder: (column) => column);
}

class $$UserTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (
      UserTableData,
      BaseReferences<_$MyDatabase, $UserTableTable, UserTableData>
    ),
    UserTableData,
    PrefetchHooks Function()> {
  $$UserTableTableTableManager(_$MyDatabase db, $UserTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<User?> user = const Value.absent(),
          }) =>
              UserTableCompanion(
            id: id,
            user: user,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<User?> user = const Value.absent(),
          }) =>
              UserTableCompanion.insert(
            id: id,
            user: user,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (
      UserTableData,
      BaseReferences<_$MyDatabase, $UserTableTable, UserTableData>
    ),
    UserTableData,
    PrefetchHooks Function()>;
typedef $$CategoryTableTableCreateCompanionBuilder = CategoryTableCompanion
    Function({
  Value<int> id,
  Value<Category?> category,
});
typedef $$CategoryTableTableUpdateCompanionBuilder = CategoryTableCompanion
    Function({
  Value<int> id,
  Value<Category?> category,
});

class $$CategoryTableTableFilterComposer
    extends Composer<_$MyDatabase, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Category?, Category, String> get category =>
      $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$MyDatabase, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Category?, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$CategoryTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $CategoryTableTable,
    CategoryTableData,
    $$CategoryTableTableFilterComposer,
    $$CategoryTableTableOrderingComposer,
    $$CategoryTableTableAnnotationComposer,
    $$CategoryTableTableCreateCompanionBuilder,
    $$CategoryTableTableUpdateCompanionBuilder,
    (
      CategoryTableData,
      BaseReferences<_$MyDatabase, $CategoryTableTable, CategoryTableData>
    ),
    CategoryTableData,
    PrefetchHooks Function()> {
  $$CategoryTableTableTableManager(_$MyDatabase db, $CategoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<Category?> category = const Value.absent(),
          }) =>
              CategoryTableCompanion(
            id: id,
            category: category,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<Category?> category = const Value.absent(),
          }) =>
              CategoryTableCompanion.insert(
            id: id,
            category: category,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $CategoryTableTable,
    CategoryTableData,
    $$CategoryTableTableFilterComposer,
    $$CategoryTableTableOrderingComposer,
    $$CategoryTableTableAnnotationComposer,
    $$CategoryTableTableCreateCompanionBuilder,
    $$CategoryTableTableUpdateCompanionBuilder,
    (
      CategoryTableData,
      BaseReferences<_$MyDatabase, $CategoryTableTable, CategoryTableData>
    ),
    CategoryTableData,
    PrefetchHooks Function()>;

class $MyDatabaseManager {
  final _$MyDatabase _db;
  $MyDatabaseManager(this._db);
  $$SettingTableTableTableManager get settingTable =>
      $$SettingTableTableTableManager(_db, _db.settingTable);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
}
