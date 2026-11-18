import 'history.dart';

class Chapter {

  // Basic info
  int id = 0;
  int workId = 0;
  int nextId = 0;
  int order = 0;

  // Main info
  String chapterListHeader = "";
  String chapterHeader = "";

  String summary = "";
  List<String> notes = [];
  List<String> endNotes = [];
  String body = "";

  // Extra
  History? history;

  DateTime lastFetchDate = DateTime.fromMillisecondsSinceEpoch(0);
  int parserVersion = -1;

  String workTitle = "";
  String author = "";




  void merge(Chapter data) {
    id = data.id;
    workId = data.workId;
    nextId = data.nextId;
    if (data.order > 0) order = data.order;

    if (data.chapterListHeader.isNotEmpty) chapterListHeader = data.chapterListHeader;
    if (data.chapterHeader.isNotEmpty) chapterHeader = data.chapterHeader;

    if (data.summary.isNotEmpty) summary = data.summary;
    if (data.notes.isNotEmpty) notes = data.notes;
    if (data.endNotes.isNotEmpty) endNotes = data.endNotes;
    if (data.body.isNotEmpty) body = data.body;

    if (data.workTitle.isNotEmpty) workTitle = data.workTitle;
    if (data.author.isNotEmpty) author = data.author;

    if (!data.lastFetchDate.isAtSameMomentAs(DateTime.fromMillisecondsSinceEpoch(0))) lastFetchDate = data.lastFetchDate;
    if (data.parserVersion > parserVersion) parserVersion = data.parserVersion;
  }

  Map<String, Object?> toMap() {
    return {
      "CHAPTER_ID": id,
      "WORK_ID": workId,
      "NEXT_ID": nextId,
      "ORDER_NUM": order,
      "WORK_TITLE": workTitle,
      "AUTHOR": author,
      "CHAPTER_LIST_HEADER": chapterListHeader,
      "CHAPTER_HEADER": chapterHeader,
      "SUMMARY": summary,
      "NOTES": notes.join("|🗱🗙|"), // Just adding something random and won't be used (probably)
      "END_NOTES": endNotes.join("|🗱🗙|"), // Maybe I'll just create a "notes" table next time 🙄
      "BODY": body,
      "LAST_FETCHED_DATE": lastFetchDate.toString(),
      "PARSER_VERSION": parserVersion,
    };
  }
}