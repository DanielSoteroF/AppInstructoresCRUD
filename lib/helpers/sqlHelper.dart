import 'dart:async';
import 'package:path/path.dart';
import 'package:instructores_app/models/instructores_model.dart';
import 'package:sqflite/sqflite.dart';

const String itemsTable = 'itemsTable';
const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String lastnameColumn = 'lastnameColumn';
const String emailColumn = 'emailColumn';
const String specialtyColumn = 'specialtyColumn';
const String phoneColumn = 'phoneColumn';
const String generoColumn = 'generoColumn';
const String imageColumn = 'imageColumn';

class SqlHelper {
  static final SqlHelper _instance = SqlHelper.internal();
  factory SqlHelper() => _instance;
  SqlHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db!;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'instructores_app.db');
    //print('Database path: $path');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute("CREATE TABLE $itemsTable ("
              "$idColumn INTEGER PRIMARY KEY AUTOINCREMENT,"
              "$nameColumn TEXT,"
              "$lastnameColumn TEXT,"
              "$emailColumn TEXT,"
              "$specialtyColumn TEXT,"
              "$phoneColumn TEXT,"
              "$generoColumn TEXT,"
              "$imageColumn TEXT"
              ")");
          print('DataBase Creada');
        });
  }

  Future<Data> insertData(Data data) async {
    Database? dbData = await db;
    data.id = await dbData.insert(itemsTable, data.toMap());
    return data;
  }

  Future<Data?> readingData(int id) async {
    Database dbData = await db;
    List<Map<String, dynamic>> maps = await dbData.query(itemsTable,
        columns: [
          idColumn,
          nameColumn,
          lastnameColumn,
          emailColumn,
          specialtyColumn,
          phoneColumn,
          generoColumn,
          imageColumn
        ],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Data.fromMap(maps.first);
    } else {
      return null;
    }
  }


  Future<int> updateData(Data data) async {
    Database dbData = await db;
    return await dbData.update(itemsTable, data.toMap(),
        where: '$idColumn = ?', whereArgs: [data.id]);
  }

  Future<int> deleteData(int? id) async {
    Database dbData = await db;
    return await dbData
        .delete(itemsTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<List<Data>> getData() async {
    Database? dbData = await db;
    List<Map<String, dynamic>> listMap = await dbData.query(itemsTable);
    List<Data> listData = [];
    for (Map<String, dynamic> map in listMap) {
      listData.add(Data.fromMap(map));
    }
    return listData;
  }

  Future<int?> getNumber() async {
    Database dbData = await db;
    return Sqflite.firstIntValue(
        await dbData.rawQuery("SELECT COUNT(*) FROM $itemsTable"));
  }

  Future close() async {
    Database dbData = await db;
    return dbData.close();
  }
}
