import 'package:sqflite/sqflite.dart';

import '../database/db.dart';

class TagsDTO {

  // ============================
  // Database Actions
  // ============================

  Future<void> updateWorkTags(int workId, List<String> tags, int type) async {
    Database db = await DB.instance.database;

    List<int> tagNewIds = [];
    List<int> tagOldIds = [];
    for (String tag in tags) {
      await db.insert("TAG", {"TAG":tag, "TAG_TYPE":type}, conflictAlgorithm: .ignore);
      tagNewIds.add((await db.query("TAG", where: "TAG_TYPE = ? AND TAG = ?", whereArgs: [type, tag]))[0]["ID"] as int);
    }
    List<Map<String, Object?>> tagCheck = await db.rawQuery("SELECT TAG_ID FROM WORK_TAGS WT JOIN TAG T ON T.ID = WT.TAG_ID WHERE T.TAG_TYPE = ? AND WT.WORK_ID = ?", [type, workId]);
    for (Map<String, Object?> row in tagCheck) {
      tagOldIds.add(row["TAG_ID"] as int);
    }
    for (int newId in tagNewIds) {
      if (!tagOldIds.contains(newId)) {
        await db.insert("WORK_TAGS", {"WORK_ID":workId, "TAG_ID":newId}, conflictAlgorithm: .ignore);
      }
      else {
        tagOldIds.remove(newId);
      }
    }
    for (int oldId in tagOldIds) {
      await db.delete("WORK_TAGS", where: "WORK_ID = ? AND TAG_ID = ?", whereArgs: [workId, oldId]);
    }
  }
}