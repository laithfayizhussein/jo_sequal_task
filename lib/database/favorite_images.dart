import 'package:flutter/cupertino.dart';

import '../models/favorite_images.dart';
import 'package:path/path.dart' as pth;
import 'package:sqflite/sqflite.dart' as sqlf;

class SqlDb {
  static sqlf.Database? _db;
  static const String id = 'id';
  static const String imageUrl = 'imageUrl';
  static const String tableName = 'favoriteImages';
  // ignore: constant_identifier_names
  static const String table_db = 'favoriteImages.db';

  // to avoid duplicate the database
  // Future<sqlf.Database?> get db async {
  Future<sqlf.Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasePath = await sqlf.getDatabasesPath();
    String path = pth.join(databasePath, table_db);
    sqlf.Database myDb = await sqlf.openDatabase(
      path,
      onCreate: _onCreate,
      version: 4,
      onUpgrade: _onUpgrade,
    );
    return myDb;
  }

  _onUpgrade(sqlf.Database db, int oldversion, int newversion) async {
    debugPrint('_onUpgrade ++++++++++++++++++++++++++++++++++++++');
    // await db.execute("ALTER TABLE favorite ADD COLUMN color TEXT");
  }

  _onCreate(sqlf.Database db, int version) async {
    await db.execute('''
        CREATE TABLE '$tableName'(
        '$id' INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
        '$imageUrl' TEXT NOT NULL
       )''');
    debugPrint(' ONCreate ++++++++++++++++++++++++++++++++++++++++++');
  }

  Future<List<Map<String, Object?>>?> getPhotos() async {
    sqlf.Database? dbClient = await db;
    var maps = await dbClient?.query(
      tableName,
      orderBy: "id",
    );
    return maps;
  }

  Future<FavoriteImages> insertData(FavoriteImages favoriteImages) async {
    sqlf.Database? myDb = await db;

    await myDb?.insert(
      tableName,
      favoriteImages.toMap(),
      conflictAlgorithm: sqlf.ConflictAlgorithm.replace,
    );

    return favoriteImages;
  }

  deleteData(String sql) async {
    sqlf.Database? myDb = await db;
    var response = myDb!.delete(tableName, where: "id=?", whereArgs: [sql]);
    return response;
  }

  deleteAllData() async {
    sqlf.Database? myDb = await db;
    myDb?.delete(tableName);

    // String databasePath = await sqlf.getDatabasesPath();
    // String path = pth.join(databasePath, table_db);
    // sqlf.deleteDatabase(path);
  }

 Future<List<Map<String, Object?>>> checkImageExistance(
    int id,
  ) async {
    sqlf.Database? myDb = await db;
    final test = await myDb?.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    return test ??[];
  }
}
