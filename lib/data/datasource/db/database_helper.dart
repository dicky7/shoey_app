import 'package:shoes_app/data/models/product_model.dart';
import 'package:shoes_app/data/models/table/product_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper? _databaseHelper;

  //The class has a private constructor _instance and a private static field _databaseHelper.
  // It also has a factory constructor that returns the singleton instance of the class
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  //The factory constructor is defined to return the singleton instance of the DatabaseHelper class.
  // It checks whether _databaseHelper is null, and if it is, it creates a new instance of the DatabaseHelper
  // class by calling the private constructor.
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  //This is a static property that holds a reference to the open database.
  static Database? _database;

  //The get database method is defined to return the database object. If _database is null,
  // it calls the _initDb method to create and initialize the database.
  Future<Database?> get database async{
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tableBookmark = "bookkmarks";

  //The _initDb method initializes the database if it doesn't already exist.
  // It creates a table called bookmarks with four columns: id, title, price, and url.
  Future<Database> _initDb() async{
    final path = await getDatabasesPath();
    final databasePath = '$path/shoey.db';

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  //function to create the table.
  void _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE  $_tableBookmark (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photo TEXT,
        price INTEGER
      );
    ''');

  }

  // The insertWatchlist method is used to insert a new bookmark into the database.
  Future<void> insertWatchlist(ProductTable product)async{
    final db = await database;
    await db!.insert(_tableBookmark, product.toJson());
  }

  //A function that retrieves all the products from the database and The results are then returned as a List of Map objects.
  Future<List<Map<String, dynamic>>>  getWatchlist() async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tableBookmark);
    return results;
  }

  //The getProductById method retrieves a single bookmark from the database based on its id
  //this function to check isBookmark true of false
  Future<Map<String, dynamic>> getProductById(int id) async{
    final db = await database;
    final result = await db!.query(
      _tableBookmark,
      where: "id = ?",
      whereArgs: [id]
    );
    if (result.isNotEmpty) {
      return result.first;
    }else{
      return {};
    }
  }

  //The removeProductById method deletes a single bookmark from the database based on its id
  Future<void> removeProductById(int id) async{
    final db = await database;
    await db!.delete(
      _tableBookmark,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  //The removeAllProduct method deletes all bookmarks from the _tableBookmark table.
  Future<void> removeAllProduct() async{
    final db = await database;
    await db!.delete(_tableBookmark);
  }
}