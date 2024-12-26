import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'user_profile.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE user_profile (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            photo_path TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> saveProfilePicture(String photoPath) async {
    final db = await database;
    return await db.insert(
      'user_profile',
      {'photo_path': photoPath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getProfilePicture() async {
    final db = await database;
    final result = await db.query(
      'user_profile',
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first['photo_path'] as String;
    }
    return null;
  }
}
