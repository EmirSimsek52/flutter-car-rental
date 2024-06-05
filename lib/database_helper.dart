import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> resetDatabase() async {
    String path = join(await getDatabasesPath(), 'car_database.db');
    await deleteDatabase(path);
    _database = null;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'car_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE rezervations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        carName TEXT,
        name TEXT,
        phoneNumber TEXT,
        pickupDate TEXT,
        returnDate TEXT,
        deliveryAddress TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE cars(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        daily_km TEXT,
        daily_price TEXT,
        image_url TEXT
      )
    ''');
  }

  Future<int> insertCar(Map<String, dynamic> car) async {
    Database db = await database;
    return await db.insert('cars', car);
  }

  Future<List<Map<String, dynamic>>> getAllCars() async {
    Database db = await database;
    return await db.query('cars');
  }

  Future<void> deleteCar(String carName) async {
    final db = await database;
    await db.delete(
      'cars',
      where: 'name = ?',
      whereArgs: [carName],
    );
  }

  Future<int> insertReservation(Map<String, dynamic> reservation) async {
    Database db = await database;
    return await db.insert('rezervations', reservation);
  }

  Future<List<Map<String, dynamic>>> getAllReservations() async {
    Database db = await database;
    return await db.query('rezervations');
  }

  Future<void> deleteReservation(int id) async {
    final db = await database;
    await db.delete(
      'rezervations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
