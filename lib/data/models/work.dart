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
  ContentRating ratingSymbol = .none;
  ContentRPO rpoSymbol = .none;
  ContentWarning warningSymbol = .none;
  ContentStatus statusSymbol = .unknown;

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




  void merge(Work data) {
    id = data.id;

    if (data.title.isNotEmpty) title = data.title;
    if (data.author.isNotEmpty) author = data.author;
    if (data.summary.isNotEmpty) summary = data.summary;

    // if (data.chapters.isNotEmpty) chapters = data.chapters;

    // Merging chapters
    // Replacing blank chapter list and single chapter since the first chapter gets parsed on load
    if (data.chapters.isNotEmpty && (chapters.isEmpty || chapters.length == 1)) chapters = data.chapters;
    // Multi chapter merge
    else if (data.chapters.isNotEmpty && chapters.isNotEmpty) {
      for (Chapter newChap in data.chapters) {
        int chapIdx = chapters.indexWhere((chap) => chap.id == newChap.id);
        if (chapIdx != -1) chapters[chapIdx].merge(newChap);
      }
    }

    if (data.ratingSymbol != .none) ratingSymbol = data.ratingSymbol;
    if (data.rpoSymbol != .none) rpoSymbol = data.rpoSymbol;
    if (data.warningSymbol != .none) warningSymbol = data.warningSymbol;
    if (data.statusSymbol != .unknown) statusSymbol = data.statusSymbol;

    if (data.rating.isNotEmpty) rating = data.rating;
    if (data.warning.isNotEmpty) warning = data.warning;
    if (data.categories.isNotEmpty) categories = data.categories;
    if (data.fandoms.isNotEmpty) fandoms = data.fandoms;
    if (data.relationships.isNotEmpty) relationships = data.relationships;
    if (data.characters.isNotEmpty) characters = data.characters;
    if (data.freeforms.isNotEmpty) freeforms = data.freeforms;
    if (data.language.isNotEmpty) language = data.language;

    if (data.publishedDate != null) publishedDate = data.publishedDate;
    if (data.lastUpdatedDate != null) lastUpdatedDate = data.lastUpdatedDate;
    if (data.completeDate != null) completeDate = data.completeDate;

    if (data.chapterStats.isNotEmpty) chapterStats = data.chapterStats;
    if (data.words > 0) words = data.words;
    if (data.comments > 0) comments = data.comments;
    if (data.kudos > 0) kudos = data.kudos;
    if (data.bookmarks > 0) bookmarks = data.bookmarks;
    if (data.hits > 0) hits = data.hits;

    lastFetchDate = data.lastFetchDate;
    parserVersion = data.parserVersion;
  }

  Map<String, Object?> toMap() {
    return {
      "ID": id,
      "TITLE": title,
      "AUTHOR": author,
      "SUMMARY": summary,

      "RATING_SYMBOL": ratingSymbol.name,
      "RPO_SYMBOL": rpoSymbol.name,
      "WARNING_SYMBOL": warningSymbol.name,
      "STATUS_SYMBOL": statusSymbol.name,

      "LANGUAGE_ID": language,
      "PUBLISHED_DATE": publishedDate?.toString(),
      "LAST_UPDATED_DATE": lastUpdatedDate?.toString(),
      "COMPLETE_DATE": completeDate?.toString(),
      "CHAPTER_STATS": chapterStats,

      "WORDS": words,
      "COMMENTS": comments,
      "KUDOS": kudos,
      "BOOKMARKS": bookmarks,
      "HITS": hits,

      "LAST_FETCHED_DATE": lastFetchDate.toString(),
      "PARSER_VERSION": parserVersion,
    };
  }
}