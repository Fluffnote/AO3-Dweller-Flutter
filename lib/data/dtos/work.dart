import 'package:ao3_dweller/data/dtos/chapter.dart';
import 'package:ao3_dweller/data/dtos/tags.dart';
import 'package:ao3_dweller/data/models/chapter.dart';
import 'package:ao3_dweller/data/models/support/symbols.dart';
import 'package:ao3_dweller/data/models/work.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../network/api.dart';

class WorkDTO {

  // ============================
  // Main calls
  // ============================

  // Gets Chapter object
  //
  // [refreshType] = 0 : Doesn't refresh - Only grabs database info
  // [refreshType] = 1 : Soft refresh - Will attempt to refresh info if it has been more than 30 days from last fetch
  // [refreshType] = 2 : Hard refresh - Will attempt to refresh info regardless of last fetch
  Future<Work> getWork(int workId, int refreshType) async {
    Work out = await pullDB(workId);

    if (refreshType == 2 || (refreshType == 1 && out.lastFetchDate.isBefore(DateTime.now().subtract(Duration(days: 30))))) {
      out.merge(await API().getWork(workId));
      await pushDB(out);
    }

    return out;
  }



  // ============================
  // Database Actions
  // ============================

  Future<void> pushDB(Work work) async {
    Database db = await DB.instance.database;

    // Store base values
    await db.insert("WORK", work.toMap(), conflictAlgorithm: .replace);

    // Cache tags

    // Rating
    await TagsDTO().updateWorkTags(work.id, work.rating.isNotEmpty ? [work.rating] : [], 2);

    // Warning
    await TagsDTO().updateWorkTags(work.id, work.warning.isNotEmpty ? [work.warning] : [], 3);

    // Categories
    await TagsDTO().updateWorkTags(work.id, work.categories, 4);

    // Fandoms
    await TagsDTO().updateWorkTags(work.id, work.fandoms, 5);

    // Relationships
    await TagsDTO().updateWorkTags(work.id, work.relationships, 6);

    // Characters
    await TagsDTO().updateWorkTags(work.id, work.characters, 7);

    // Freeforms
    await TagsDTO().updateWorkTags(work.id, work.freeforms, 8);

    // Cache chapters
    for (var chapter in work.chapters) { await ChapterDTO().pushPartialDB(chapter); }
  }

  Future<Work> pullDB(int workId) async {
    Database db = await DB.instance.database;
    Work out = Work();

    final List<Map<String, Object?>> result =
      await db.query("WORK", where: "ID = ?", whereArgs: [workId]);

    if (result.isNotEmpty) {

      // Grab Base
      out.id = result[0]["ID"] as int;
      out.title = result[0]["TITLE"] as String;
      out.author = result[0]["AUTHOR"] as String;
      out.summary = result[0]["SUMMARY"] as String;

      out.ratingSymbol = ContentRating.values.byName((result[0]["RATING_SYMBOL"] as String));
      out.rpoSymbol = ContentRPO.values.byName((result[0]["RPO_SYMBOL"] as String));
      out.warningSymbol = ContentWarning.values.byName((result[0]["WARNING_SYMBOL"] as String));
      out.statusSymbol = ContentStatus.values.byName((result[0]["STATUS_SYMBOL"] as String));

      out.language = result[0]["LANGUAGE_ID"] as String;
      String? temp = result[0]["PUBLISHED_DATE"] as String?;
      out.publishedDate = temp!=null?DateTime.parse(temp):null;
      String? temp1 = result[0]["PUBLISHED_DATE"] as String?;
      out.publishedDate = temp1!=null?DateTime.parse(temp1):null;
      String? temp2 = result[0]["PUBLISHED_DATE"] as String?;
      out.publishedDate = temp2!=null?DateTime.parse(temp2):null;
      out.chapterStats = result[0]["CHAPTER_STATS"] as String;

      out.words = result[0]["WORDS"] as int;
      out.comments = result[0]["COMMENTS"] as int;
      out.kudos = result[0]["KUDOS"] as int;
      out.bookmarks = result[0]["BOOKMARKS"] as int;
      out.hits = result[0]["HITS"] as int;

      out.lastFetchDate = DateTime.parse(result[0]["LAST_FETCHED_DATE"] as String);
      out.parserVersion = result[0]["PARSER_VERSION"] as int;

      // Grab Tags
      // Rating
      List<Map<String, Object?>> rating = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 2 AND WT.WORK_ID = ?", [workId]);
      out.rating = rating.isNotEmpty ? (rating[0]["TAG"] as String) : "";
      // Warning
      List<Map<String, Object?>> warning = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 3 AND WT.WORK_ID = ?", [workId]);
      out.warning = warning.isNotEmpty ? (warning[0]["TAG"] as String) : "";
      // Categories
      List<Map<String, Object?>> categories = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 4 AND WT.WORK_ID = ?", [workId]);
      categories.forEach((item) { out.categories.add(item["TAG"] as String); });
      // Fandoms
      List<Map<String, Object?>> fandoms = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 5 AND WT.WORK_ID = ?", [workId]);
      fandoms.forEach((item) { out.fandoms.add(item["TAG"] as String); });
      // Relationships
      List<Map<String, Object?>> relationships = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 6 AND WT.WORK_ID = ?", [workId]);
      relationships.forEach((item) { out.relationships.add(item["TAG"] as String); });
      // Characters
      List<Map<String, Object?>> characters = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 7 AND WT.WORK_ID = ?", [workId]);
      characters.forEach((item) { out.characters.add(item["TAG"] as String); });
      // Freeforms
      List<Map<String, Object?>> freeforms = await db.rawQuery("SELECT TAG FROM TAG T JOIN WORK_TAGS WT ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = 8 AND WT.WORK_ID = ?", [workId]);
      freeforms.forEach((item) { out.freeforms.add(item["TAG"] as String); });

      // Grab Chapters
      out.chapters = await ChapterDTO().pullListDB(workId);
    }

    return out;
  }
}