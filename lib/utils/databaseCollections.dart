import 'package:news_app/model/favoriteArticle.dart';
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

//void _createDb(Database db, int newVersion) async {
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "tradecraft.db"), onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE collections(
      collectionName TEXT
      )
      ''');

      await db.execute('''
      CREATE TABLE favoriteArticles(
      sourceID TEXT, sourceName TEXT ,  sourceDescription TEXT , sourceURL TEXT , sourceCategory TEXT , sourceCountry TEXT, sourceLanguage TEXT, author TEXT ,
      title TEXT , description TEXT , url TEXT , img TEXT , date TEXT , content TEXT , collectionName TEXT
      )
      ''');
      Batch batch = db.batch();
      batch.insert('collections', {'collectionName': 'collectionTRYYYYYY'});
      batch.insert('collections', {'collectionName': 'collectionTRYY222222'});
      batch.insert('favoriteArticles', {
        'sourceID': 'sourceIDTRY',
        'sourceName': 'sourceNameTry',
        'sourceDescription': 'sourceDescriptionTry',
        'sourceURL': 'sourceURL',
        'sourceCategory': 'sourceURL',
        'sourceCountry': 'sourceURL',
        'sourceLanguage': 'sourceURL',
        'author': 'sourceURL',
        'title': 'sourceURL',
        'description': 'sourceURL',
        'url': 'sourceURL',
        'img': 'sourceURL',
        'date': 'sourceURL',
        'content': 'sourceURL',
        'collectionName': 'sourceURL',
      });
      // batch.insert('coin', {'coinID': 'binancecoin', 'coinName': 'Binance Coin', 'coinTicker': 'BNB'});
      batch.commit();
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

  newFavoriteArticle(FavoriteArticle newFavoriteArticle) async {
    final db = await database;
    var res = await db.rawInsert('''
      iNSERT INTO favoriteArticles (
      sourceID , sourceName , sourceDescription ,sourceURL , sourceCategory , sourceCountry, sourceLanguage , author , title , description , url , img , date ,content , collectionName
      ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''', [
      newFavoriteArticle.sourceID,
      newFavoriteArticle.sourceName,
      newFavoriteArticle.sourceDescription,
      newFavoriteArticle.sourceURL,
      newFavoriteArticle.sourceCategory,
      newFavoriteArticle.sourceCountry,
      newFavoriteArticle.sourceLanguage,
      newFavoriteArticle.author,
      newFavoriteArticle.title,
      newFavoriteArticle.description,
      newFavoriteArticle.url,
      newFavoriteArticle.img,
      newFavoriteArticle.date,
      newFavoriteArticle.content,
      newFavoriteArticle.collectionName
    ]);
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

  Future<dynamic> getFavoriteArticles() async {
    final db = await database;
    var res = await db.query("favoriteArticles");
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res;
      return resMap.isNotEmpty ? resMap : null;
    }
  }
}
