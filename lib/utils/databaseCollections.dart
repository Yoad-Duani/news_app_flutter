import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:news_app/model/Collection.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'collectionDB'), onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE collections(
      collectionName TEXT
      )
      ''');
      // Batch batch = db.batch();
      // batch.insert('coin', {'coinID': 'bitcoin', 'coinName': 'Bitcoin', 'coinTicker': 'BTC'});
      // batch.insert('coin', {'coinID': 'ethereum', 'coinName': 'Ethereum', 'coinTicker': 'ETH'});
      // batch.insert('coin', {'coinID': 'binancecoin', 'coinName': 'Binance Coin', 'coinTicker': 'BNB'});
      // batch.insert('coin', {'coinID': 'ripple', 'coinName': 'Ripple', 'coinTicker': 'XRP'});
      // batch.insert('coin', {'coinID': 'tether', 'coinName': 'Tether', 'coinTicker': 'USDT'});
      // batch.insert('coin', {'coinID': 'cardano', 'coinName': 'Cardano', 'coinTicker': 'ADA'});
      // batch.insert('coin', {'coinID': 'dogecoin', 'coinName': 'Dogecoin', 'coinTicker': 'DOGE'});
      // batch.insert('coin', {'coinID': 'polkadot', 'coinName': 'Polkadot', 'coinTicker': 'DOT'});
      // batch.insert('coin', {'coinID': 'bitcoin-cash', 'coinName': 'Bitcoin Cash', 'coinTicker': 'BCH'});
      // batch.insert('coin', {'coinID': 'litecoin', 'coinName': 'Litecoin', 'coinTicker': 'LTC'});
      // batch.commit();
    }, version: 1);
  }

  newCollection(Collection newCollection) async {
    final db = await database;

    var res = await db.rawInsert('''
      iNSERT INTO collections (
      collectionName
      ) VALUES (?)
    ''', [newCollection.collectionName]);

    print(await getDatabasesPath());
    print('ok');
    return res;
  }

  Future<dynamic> getCollection() async {
    final db = await database;
    var res = await db.query("collections");
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? resMap : null;
    }
  }
}
