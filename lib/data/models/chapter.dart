import 'history.dart';

class Chapter {

  // Basic info
  int id = 0;
  int workId = 0;
  int nextId = 0;
  int order = 1;

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
}