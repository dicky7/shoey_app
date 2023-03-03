import 'package:shoes_app/data/models/table/cart_table.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper{
  static CartDatabaseHelper? _databaseHelper;

  //The class has a private constructor _instance and a private static field _databaseHelper.
  // It also has a factory constructor that returns the singleton instance of the class
  CartDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  //The factory constructor is defined to return the singleton instance of the CartDatabaseHelper class.
  // It checks whether _databaseHelper is null, and if it is, it creates a new instance of the CartDatabaseHelper
  // class by calling the private constructor.
  factory CartDatabaseHelper() => _databaseHelper ?? CartDatabaseHelper._instance();

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

  static const String _tableCart = "cart";

  //The _initDb method initializes the database if it doesn't already exist.
  // It creates a table called bookmarks with four columns: id, title, price, and url.
  Future<Database> _initDb() async{
    final path = await getDatabasesPath();
    final databasePath = "$path/cart.db";

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  //function to create the table.
  void _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE $_tableCart (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photo TEXT,
        price INTEGER,
        quantity INTEGER
      );
   ''');
  }

  // The insertCart method is used to insert a new cart into the database.
  Future<void> insertCart(CartTable cart)async{
    final db = await database;
    await db!.insert(_tableCart, cart.toJson());
  }

  //A function that retrieves all the products from the database and The results are then returned as a List of Map objects.
  Future<List<Map<String, dynamic>>>  getListCart() async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tableCart);
    return results;
  }

  //The getCartById method retrieves a single cart from the database based on its id
  //this function to check isBookmark true of false
  Future<Map<String, dynamic>> getCartById(int id) async{
    final db = await database;
    final result = await db!.query(
        _tableCart,
        where: "id = ?",
        whereArgs: [id]
    );
    if (result.isNotEmpty) {
      return result.first;
    }else{
      return {};
    }
  }

  //The removeCartById method deletes a single bookmark from the database based on its id
  Future<void> removeCartById(int id) async{
    final db = await database;
    await db!.delete(
        _tableCart,
        where: "id = ?",
        whereArgs: [id]
    );
  }


  Future<void> updateCart(CartTable cart) async{
    final db = await database;
    await db!.update(
      _tableCart,
      cart.toJson(),
      where: "id = ?",
      whereArgs: [cart.id]
    );
  }

  //The removeAllCart method deletes all bookmarks from the _tableBookmark table.
  Future<void> removeAllCart() async{
    final db = await database;
    await db!.delete(_tableCart);
  }

}