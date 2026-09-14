import 'package:json_annotation/json_annotation.dart';

part 'param_map.g.dart';

// Creating a single json generator for consolidation purposes
@JsonSerializable()
class ParamMap {

  // ============================
  // Work Filter url query params
  // ============================

  // Work Info
  @JsonKey(name: "work_search[query]")
  String? workQuery;
  @JsonKey(name: "work_search[title]")
  String? workTitle;
  @JsonKey(name: "work_search[creators]")
  String? workCreators;
  @JsonKey(name: "work_search[revised_at]")
  String? workRevisedAt;
  @JsonKey(name: "work_search[complete]")
  String? workComplete;
  @JsonKey(name: "work_search[crossover]")
  String? workCrossover;
  @JsonKey(name: "work_search[language_id]")
  String? workLanguageId;

  // Work Tags
  @JsonKey(name: "work_search[rating_ids]")
  String? workRatingIds;
  @JsonKey(name: "work_search[fandom_names]")
  String? workFandomNames;
  @JsonKey(name: "work_search[relationship_names]")
  String? workRelationshipNames;
  @JsonKey(name: "work_search[character_names]")
  String? workCharacterNames;
  @JsonKey(name: "work_search[archive_warning_ids]")
  String? workArchiveWarningIds;
  @JsonKey(name: "work_search[category_ids]")
  String? workCategoryIds;
  @JsonKey(name: "work_search[freeform_names]")
  String? workFreeformNames;

  // Work Stats
  @JsonKey(name: "work_search[single_chapter]", toJson: booleanToIntStringJSON)
  bool? workSingleChapter;
  @JsonKey(name: "work_search[word_count]")
  String? workWordCount;
  @JsonKey(name: "work_search[hits]")
  String? workHits;
  @JsonKey(name: "work_search[kudos_count]")
  String? workKudosCount;
  @JsonKey(name: "work_search[comments_count]")
  String? workCommentsCount;
  @JsonKey(name: "work_search[bookmarks_count]")
  String? workBookmarksCount;

  // Work Search
  @JsonKey(name: "work_search[sort_column]")
  String? workSortColumn;
  @JsonKey(name: "work_search[sort_direction]")
  String? workSortDirection;



  // ============================
  // People Filter url query params
  // ============================

  @JsonKey(name: "people_search[query]")
  String? peopleQuery;
  @JsonKey(name: "people_search[name]")
  String? peopleName;
  @JsonKey(name: "people_search[fandom]")
  String? peopleFandom;



  // ============================
  // Tag Filter url query params
  // ============================

  @JsonKey(name: "tag_search[name]")
  String? tagName;
  @JsonKey(name: "tag_search[fandoms]")
  String? tagFandoms;
  @JsonKey(name: "tag_search[type]")
  String? tagType;
  @JsonKey(name: "tag_search[wrangling_status]")
  String? tagWranglingStatus;
  @JsonKey(name: "tag_search[sort_column]")
  String? tagSortColumn;
  @JsonKey(name: "tag_search[sort_direction]")
  String? tagSortDirection;



  // ============================
  // Bookmark Filter url query params
  // ============================

  // Work Info
  @JsonKey(name: "bookmark_search[bookmarkable_query]")
  String? bookmarkWorkQuery;
  @JsonKey(name: "bookmark_search[other_tag_names]")
  String? bookmarkWorkTags;
  @JsonKey(name: "bookmark_search[bookmarkable_type]")
  String? bookmarkTypes;
  @JsonKey(name: "bookmark_search[word_count]")
  String? bookmarkWordCount;
  @JsonKey(name: "bookmark_search[language_id]")
  String? bookmarkLanguage;
  @JsonKey(name: "bookmark_search[bookmarkable_date]")
  String? bookmarkDateUpdated;

  // Bookmark Info
  @JsonKey(name: "bookmark_search[bookmark_query]")
  String? bookmarkBookmarkQuery;
  @JsonKey(name: "bookmark_search[other_bookmark_tag_names]")
  String? bookmarkBookmarkTags;
  @JsonKey(name: "bookmark_search[bookmarker]")
  String? bookmarkBookmarker;
  @JsonKey(name: "bookmark_search[bookmark_notes]")
  String? bookmarkNotes;
  @JsonKey(name: "bookmark_search[rec]", toJson: booleanToIntStringJSON)
  bool? bookmarkRec;
  @JsonKey(name: "bookmark_search[with_notes]", toJson: booleanToIntStringJSON)
  bool? bookmarkWithNotes;
  @JsonKey(name: "bookmark_search[date]")
  String? bookmarkDateBookmarked;

  // Search
  @JsonKey(name: "bookmark_search[sort_column]")
  String? bookmarkSortBy;



  // ============================
  // Shared Filter url query params
  // ============================

  @JsonKey()
  String? commit;
  @JsonKey()
  String page = "1";



  static String? booleanToIntStringJSON(bool? value) => value!=null?(value?"1":"0"):null;

  Map<String, dynamic> toJson() => _$ParamMapToJson(this);

}