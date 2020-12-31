import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/*
 * @ClassName db_util
 * 作者: szj
 * 时间: 2020/12/29 16:08
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class DBUtil {
  // 单例公开访问点
  factory DBUtil() => getInstance();

  // 静态私有成员，没有初始化
  static DBUtil _dbUtil;

  static final String spName = "my_sp2.db";

  // 私有构造函数
  DBUtil._() {
    // 具体初始化代码
    getDataBase(spName);
  }

  // 静态、同步、私有访问点
  static DBUtil getInstance() {
    if (_dbUtil == null) {
      _dbUtil = DBUtil._();
    }
    return _dbUtil;
  }

  /// 初始化数据库存储路径
  static Future<Database> getDataBase(String dbName) async {
    //获取应用文件目录类似于Ios的NSDocumentDirectory和Android上的 AppData目录
    final fileDirectory = await getApplicationDocumentsDirectory();

    //获取存储路径
    final dbPath = fileDirectory.path;

    //构建数据库对象
    Database database = await openDatabase(dbPath + "/" + dbName, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT)");
    });

    return database;
  }

  /// 利用Sqflite数据库存储数据
  setString(String title) async {
    final db = await getDataBase(spName);
    //写入字符串
    db.transaction(
        (trx) => trx.rawInsert('INSERT INTO user(name) VALUES("$title")'));
  }

  /**
   * 获取存在Sqflite数据库中的数据
   */
  String _storageString = "";
  Future<String> getString() async {
    final db = await getDataBase(spName);
    var dbPath = db.path;
    var listSize;
    // db.rawQuery('SELECT * FROM user').then((List<Map> lists) {
    //   print('----------------$lists');
    //   listSize = lists.length;
    //   //获取数据库中的最后一条数据
    //   _storageString = lists.toString();
    // });
    return dbPath;

  }
}
