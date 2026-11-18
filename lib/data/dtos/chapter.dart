import 'package:ao3_dweller/data/network/api.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../models/chapter.dart';

class ChapterDTO {

  // ============================
  // Main calls
  // ============================

  // Gets Chapter object
  //
  // [refreshType] = 0 : Doesn't refresh - Only grabs database info
  // [refreshType] = 1 : Soft refresh - Will attempt to refresh info if it has been more than 30 days from last fetch
  // [refreshType] = 2 : Hard refresh - Will attempt to refresh info regardless of last fetch
  Future<Chapter> getChapter(int workId, int chapterId, int refreshType) async {
    Chapter out = await pullDB(workId, chapterId);

    if (refreshType == 2 || (refreshType == 1 && out.lastFetchDate.isBefore(DateTime.now().subtract(Duration(days: 30))))) {
      out.merge(await API().getChapter(workId, chapterId));
      await pushDB(out);
    }

    return out;
  }



  // ============================
  // Database Actions
  // ============================

  Future<void> pushDB(Chapter chapter) async {
    Database db = await DB.instance.database;

    await db.insert("CHAPTER", chapter.toMap(), conflictAlgorithm: .replace);
  }

  // Pushing info gotten from work that has no body, etc
  Future<void> pushPartialDB(Chapter chapter) async {
    Database db = await DB.instance.database;

    int id =  await db.insert("CHAPTER", chapter.toMap(), conflictAlgorithm: .ignore); // Try normal insert first
    if (id == -1) { // Chapter already exists, update metadata instead
      Map<String, Object?> temp = chapter.toMap();
      temp.removeWhere((k, v) => ["CHAPTER_HEADER", "SUMMARY", "NOTES", "END_NOTES", "BODY", "LAST_FETCHED_DATE", "PARSER_VERSION"].contains(k));
      await db.update("CHAPTER", temp, where: "WORK_ID = ? AND CHAPTER_ID = ?", whereArgs: [chapter.workId, chapter.id]);
    }
  }

  Future<Chapter> pullDB(int workId, int chapterId) async {
    Database db = await DB.instance.database;
    Chapter out = Chapter();

    final List<Map<String, Object?>> result =
      await db.query("CHAPTER", where: "WORK_ID = ? AND CHAPTER_ID = ?", whereArgs: [workId, chapterId]);

    if (result.isNotEmpty) {
      out.workId = result[0]["WORK_ID"] as int;
      out.id = result[0]["CHAPTER_ID"] as int;
      out.nextId = result[0]["NEXT_ID"] as int;
      out.order = result[0]["ORDER_NUM"] as int;
      out.workTitle = result[0]["WORK_TITLE"] as String;
      out.author = result[0]["AUTHOR"] as String;
      out.chapterListHeader = result[0]["CHAPTER_LIST_HEADER"] as String;
      out.chapterHeader = result[0]["CHAPTER_HEADER"] as String;
      out.summary = result[0]["SUMMARY"] as String;
      out.notes = (result[0]["NOTES"] as String).split("|🗱🗙|");
      out.endNotes = (result[0]["END_NOTES"] as String).split("|🗱🗙|");
      out.body = result[0]["BODY"] as String;
      out.lastFetchDate = DateTime.parse(result[0]["LAST_FETCHED_DATE"] as String);
      out.parserVersion = result[0]["PARSER_VERSION"] as int;
    }

    return out;
  }

  Future<List<Chapter>> pullListDB(int workId) async {
    Database db = await DB.instance.database;
    List<Chapter> list = [];

    final List<Map<String, Object?>> result =
        await db.query("CHAPTER", where: "WORK_ID = ?", whereArgs: [workId], orderBy: "ORDER_NUM ASC");

    if (result.isNotEmpty) {
      for (Map<String, Object?> row in result) {
        Chapter out = Chapter();

        out.workId = row["WORK_ID"] as int;
        out.id = row["CHAPTER_ID"] as int;
        out.nextId = row["NEXT_ID"] as int;
        out.order = row["ORDER_NUM"] as int;
        out.workTitle = row["WORK_TITLE"] as String;
        out.author = row["AUTHOR"] as String;
        out.chapterListHeader = row["CHAPTER_LIST_HEADER"] as String;
        out.chapterHeader = row["CHAPTER_HEADER"] as String;
        out.summary = row["SUMMARY"] as String;
        out.notes = (row["NOTES"] as String).split("|🗱🗙|");
        out.endNotes = (row["END_NOTES"] as String).split("|🗱🗙|");
        out.body = row["BODY"] as String;
        out.lastFetchDate = DateTime.parse(row["LAST_FETCHED_DATE"] as String);
        out.parserVersion = row["PARSER_VERSION"] as int;

        list.add(out);
      }
    }

    return list;
  }
}