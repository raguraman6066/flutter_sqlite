import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite_flutter/DBHelper/database_connection.dart';

class Repository {
  final DBConnection _dataBaseConnection =
      DBConnection(); //create instance for db

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dataBaseConnection.setDatabase();
      return _database;
    }
  }

  //insert user
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //read user
  readAllData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //read one data
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //update user
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //delete one data
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete('delete from $table where id=$itemId');
  }
}
