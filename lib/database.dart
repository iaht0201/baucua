import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage_flutter/model.dart';

/// Tạo một private constructor
class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'TestDB.db');

    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'TestDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Client("
            "id INTEGER PRIMARY KEY,"
            "first_name TEXT,"
            "last_name TEXT,"
            "blocked BIT"
            ")");
      },
    );
  }

// Sử dụng rawInsert
  newRawInsert(Client newClient) async {
    final db = await database;
    var res = await db!.rawInsert("INSERT Into Client (id, first_name)"
        "VALUES (${newClient.id}, ${newClient.firtsName})");
    return res;
  }

// Sử dụng insert
  newInsert(Client newClient) async {
    final db = await database;
    var res = await db!.insert("Client", newClient.toMap());
    return res;
  }

  // id lon nhat lam id moi
  newClient(Client newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db!.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    var id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (id,first_name,last_name,blocked)"
        " VALUES (?,?,?,?)",
        [id, newClient.firtsName, newClient.lastName, newClient.blocked]);

        print(id) ;
    return raw;
  }

  // get client by id
  getClient(int id) async {
    final db = await database;
    var res = await db!.query("Client", where: "id= ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : Null;
  }

  //get all client voi dieu kien
   Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db!.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  // chi nhanh nhung blocked Client
  getBlockedClients() async {
    final db = await database;
    var res = await db!.rawQuery("SELECT * FROM Client WHERE blocked =1");
    List<Client>? list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : null;
    return list;
  }

  // Update data
  updateClient(Client newClient) async {
    final db = await database;
    var res = db!.update("Client", newClient.toMap(),
        where: "id=?", whereArgs: [newClient.id]);
    return res;
  }

  // block hoặc unblock 1 client
  blockOrUnBlock(Client client) async {
    final db = await database;
    Client blocked = Client(
      firtsName: client.firtsName,
      lastName: client.lastName,
      id: client.id,
      blocked: !client.blocked,
    );
    var res = await db!.update("Client", blocked.toMap(),
        where: "id=? ", whereArgs: [client.id]);

    return res;
  }

  // xoa du lieu
  deleteClient(int id) async {
    final db = await database;
    db!.delete("Client", where: "id =? ", whereArgs: [id]);
  }

  // xoa tat ca cline
  deteleAllClient() async {
    final db = await database;
    db!.rawDelete("DELETE * FROM Client");
  }
}
