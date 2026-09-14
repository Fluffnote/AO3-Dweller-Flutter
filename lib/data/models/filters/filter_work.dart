import 'package:ao3_dweller/data/models/support/param_map.dart';

import '../support/search_options.dart';
import 'filter.dart';

class WorkFilter implements Filter {

  @override
  String searchBase = "works/search";
  @override
  String searchCommit = "Search";

  // Work Info
  String query = "";
  String title = "";
  String creators = "";
  String revisedAt = "";
  CompletionStatus complete = CompletionStatus.all;
  Crossovers crossover = Crossovers.include;
  LanguageOptions language = LanguageOptions.any;

  // Work Tags
  String ratingIds = "";
  List<String> archiveWarningIds = [];
  List<String> categoryIds = [];

  TagSet fandomNames = TagSet();
  TagSet relationshipNames = TagSet();
  TagSet characterNames = TagSet();
  TagSet freeformNames = TagSet();

  // Work Stats
  bool singleChapter = false;
  String wordCount = "";
  String hitsCount = "";
  String kudosCount = "";
  String commentsCount = "";
  String bookmarksCount = "";

  // Search
  SortColumnWork sortColumn = SortColumnWork.bestMatch;
  SortDirection sortDirection = SortDirection.desc;

  @override
  void copyFrom(Filter input) {
    if (input.runtimeType == WorkFilter) {
      WorkFilter temp = input as WorkFilter;

      query = temp.query;
      title = temp.title;
      creators = temp.creators;
      revisedAt = temp.revisedAt;
      complete = temp.complete;
      crossover = temp.crossover;
      language = temp.language;

      ratingIds = temp.ratingIds;
      archiveWarningIds = temp.archiveWarningIds;
      categoryIds = temp.categoryIds;

      fandomNames = temp.fandomNames;
      relationshipNames = temp.relationshipNames;
      characterNames = temp.characterNames;
      freeformNames = temp.freeformNames;

      singleChapter = temp.singleChapter;
      wordCount = temp.wordCount;
      hitsCount = temp.hitsCount;
      kudosCount = temp.kudosCount;
      commentsCount = temp.commentsCount;
      bookmarksCount = temp.bookmarksCount;

      sortColumn = temp.sortColumn;
      sortDirection = temp.sortDirection;
    }
  }

  @override
  ParamMap paramMap() {
    ParamMap out = ParamMap();

    out.workQuery = (query + buildTagQueryAddition());
    out.workTitle = title;
    out.workCreators = creators;
    out.workRevisedAt = revisedAt;
    out.workComplete = complete.code;
    out.workCrossover = crossover.code;
    out.workLanguageId = language.code;

    out.workRatingIds = ratingIds;
    out.workFandomNames = fandomNames.mustHaveTags.join(",");
    out.workRelationshipNames = relationshipNames.mustHaveTags.join(",");
    out.workCharacterNames = characterNames.mustHaveTags.join(",");
    out.workArchiveWarningIds = archiveWarningIds.join(",");
    out.workCategoryIds = categoryIds.join(",");
    out.workFreeformNames = freeformNames.mustHaveTags.join(",");

    out.workSingleChapter = singleChapter;
    out.workWordCount = wordCount;
    out.workHits = hitsCount;
    out.workKudosCount = kudosCount;
    out.workCommentsCount = commentsCount;
    out.workBookmarksCount = bookmarksCount;

    out.workSortColumn = sortColumn.code;
    out.workSortDirection = sortDirection.code;

    out.commit = searchCommit;

    return out;
  }



  String buildTagQueryAddition() {
    String out = "";

    List<TagSet> loop  = [fandomNames, relationshipNames, characterNames, freeformNames];

    for(TagSet tagSet in loop) {
      for(String tag in tagSet.canHaveTags) {
        out += ' "$tag"';
      }

      for(String tag in tagSet.excludeTags) {
        out += ' -"$tag"';
      }
    }

    return out;
  }
  
}