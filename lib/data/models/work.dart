import 'package:ao3_dweller/data/models/support/symbols.dart';

import 'chapter.dart';

class Work {

  // Basic info
  int id = 0;
  String title = "";
  String author = "";
  String summary = "";

  List<Chapter> chapters = [];

  // Info symbols
  ContentRating ratingSymbol = ContentRating.none;
  ContentRPO rpoSymbol = ContentRPO.none;
  ContentWarning warningSymbol = ContentWarning.none;
  ContentStatus statusSymbol = ContentStatus.unknown;

  // Tags & info
  String rating = "";
  String warning = "";
  List<String> categories = [];
  List<String> fandoms = [];
  List<String> relationships = [];
  List<String> characters = [];
  List<String> freeforms = [];
  String language = "";

  // Stats
  DateTime? publishedDate;
  DateTime? lastUpdatedDate;
  DateTime? completeDate;
  String chapterStats = "";
  int words = 0;
  int comments = 0;
  int kudos = 0;
  int bookmarks = 0;
  int hits = 0;

  // Extra
  bool bookmarked = false;
  int? resumeChapterId;
  DateTime lastFetchDate = DateTime.fromMillisecondsSinceEpoch(0);
  int parserVersion = -1;

}