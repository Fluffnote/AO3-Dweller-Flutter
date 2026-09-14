import 'package:ao3_dweller/data/models/support/param_map.dart';

import '../support/search_options.dart';
import 'filter.dart';

class BookmarkFilter implements Filter{
  @override
  String searchBase = "bookmarks/search";
  @override
  String searchCommit = "Search Bookmarks";

  // Work Info
  String workQuery = "";
  List<String> workTags = [];
  BookmarkTypes types = BookmarkTypes.any;
  String wordCount = "";
  LanguageOptions language = LanguageOptions.any;
  String dateUpdated = "";

  // Bookmark Info
  String bookmarkQuery = "";
  List<String> bookmarkTags = [];
  String bookmarker = "";
  String notes = "";
  bool bookmarkRec = false;
  bool bookmarkWithNotes = false;
  String dateBookmarked = "";

  // Search
  SortByBookmark sortBy = SortByBookmark.bestMatch;


  @override
  void copyFrom(Filter input) {
    if (input.runtimeType == BookmarkFilter) {
      BookmarkFilter temp = input as BookmarkFilter;

      workQuery = temp.workQuery;
      workTags = temp.workTags;
      types = temp.types;
      wordCount = temp.wordCount;
      language = temp.language;
      dateUpdated = temp.dateUpdated;

      bookmarkQuery = temp.bookmarkQuery;
      bookmarkTags = temp.bookmarkTags;
      bookmarker = temp.bookmarker;
      notes = temp.notes;
      bookmarkRec = temp.bookmarkRec;
      bookmarkWithNotes = temp.bookmarkWithNotes;
      dateBookmarked = temp.dateBookmarked;

      sortBy = temp.sortBy;
    }
  }

  @override
  ParamMap paramMap() {
    ParamMap out = ParamMap();

    out.bookmarkWorkQuery = workQuery;
    out.bookmarkWorkTags = workTags.join(",");
    out.bookmarkTypes = types.code;
    out.bookmarkWordCount = wordCount;
    out.bookmarkLanguage = language.code;
    out.bookmarkDateUpdated = dateUpdated;

    out.bookmarkBookmarkQuery = bookmarkQuery;
    out.bookmarkBookmarkTags = bookmarkTags.join(",");
    out.bookmarkBookmarker = bookmarker;
    out.bookmarkNotes = notes;
    out.bookmarkRec = bookmarkRec;
    out.bookmarkWithNotes = bookmarkWithNotes;
    out.bookmarkDateBookmarked = dateBookmarked;

    out.bookmarkSortBy = sortBy.code;

    out.commit = searchCommit;

    return out;
  }


}