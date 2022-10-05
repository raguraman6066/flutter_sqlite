import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBConnection {
  Future<Database> setDatabase() async {
    var directory =
        await getApplicationDocumentsDirectory(); //get existing path
    var path = join(directory.path, 'db-crud'); //create new path and create db
    var database = await openDatabase(path,
        version: 1, onCreate: _createDatabase); //create table
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        'CREATE TABLE user (id INTEGER PRIMARY KEY,name TEXT,mobile TEXT,description TEXT);';
    await database.execute(sql);
  }
}
