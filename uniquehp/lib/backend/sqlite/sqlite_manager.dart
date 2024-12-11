import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'uniquehp',
      'uniquehp.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<SearchQueryRow>> searchQuery({
    String? columnName,
    int? limitCount,
    String? searchVal,
  }) =>
      performSearchQuery(
        _database,
        columnName: columnName,
        limitCount: limitCount,
        searchVal: searchVal,
      );

  Future<List<InitialQueryRow>> initialQuery() => performInitialQuery(
        _database,
      );

  Future<List<HeaderQueryRow>> headerQuery({
    int? compId,
    String? contNo,
  }) =>
      performHeaderQuery(
        _database,
        compId: compId,
        contNo: contNo,
      );

  Future<List<DetailsQueryRow>> detailsQuery({
    int? compId,
    String? contNo,
  }) =>
      performDetailsQuery(
        _database,
        compId: compId,
        contNo: contNo,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  /// END UPDATE QUERY CALLS
}
