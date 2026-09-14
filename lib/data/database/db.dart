import 'package:ao3_dweller/data/database/upgrade_path.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqflite_logger.dart';



class DB {

  static final DB _db = new DB._internal();
  DB._internal();
  static DB get instance => _db;
  static var _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _init();
    return _database;
  }

  Future<Database> _init() async{
    var factoryWithLogs = SqfliteDatabaseFactoryLogger(databaseFactory,
                              options: SqfliteLoggerOptions(
                                  type: SqfliteDatabaseFactoryLoggerType.all));
    return await factoryWithLogs.openDatabase(
      join(await getDatabasesPath(), 'library.db'),
      options: OpenDatabaseOptions(
        version: UpgradePath().dbVersion,
        onConfigure: onConfigure,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete,
        onOpen: onOpen,
      ),
    );
  }



  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future onCreate(Database db, int version) async {
    for (String stmt in UpgradePath().getCreateStmts()) {
      await db.execute(stmt);
    }
  }

  Future onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (String stmt in UpgradePath().getUpdateStmts(oldVersion)) {
      await db.execute(stmt);
    }
  }

  Future onOpen(Database db) async {
    // Cache clean up
    await db.execute("DELETE FROM WORK WHERE ID NOT IN (SELECT WORK_ID FROM LIBRARY)");
    await db.execute("DELETE FROM WORK_TAGS WHERE WORK_ID NOT IN (SELECT ID FROM WORK)");
    await db.execute("DELETE FROM TAG WHERE ID NOT IN (SELECT TAG_ID FROM WORK_TAGS)");
  }
}