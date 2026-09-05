// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'param-map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParamMap _$ParamMapFromJson(Map<String, dynamic> json) => ParamMap()
  ..workQuery = json['work_search[query]'] as String?
  ..workTitle = json['work_search[title]'] as String?
  ..workCreators = json['work_search[creators]'] as String?
  ..workRevisedAt = json['work_search[revised_at]'] as String?
  ..workComplete = json['work_search[complete]'] as String?
  ..workCrossover = json['work_search[crossover]'] as String?
  ..workLanguageId = json['work_search[language_id]'] as String?
  ..workRatingIds = json['work_search[rating_ids]'] as String?
  ..workFandomNames = json['work_search[fandom_names]'] as String?
  ..workRelationshipNames = json['work_search[relationship_names]'] as String?
  ..workCharacterNames = json['work_search[character_names]'] as String?
  ..workArchiveWarningIds = json['work_search[archive_warning_ids]'] as String?
  ..workCategoryIds = json['work_search[category_ids]'] as String?
  ..workFreeformNames = json['work_search[freeform_names]'] as String?
  ..workSingleChapter = json['work_search[single_chapter]'] as bool?
  ..workWordCount = json['work_search[word_count]'] as String?
  ..workHits = json['work_search[hits]'] as String?
  ..workKudosCount = json['work_search[kudos_count]'] as String?
  ..workCommentsCount = json['work_search[comments_count]'] as String?
  ..workBookmarksCount = json['work_search[bookmarks_count]'] as String?
  ..workSortColumn = json['work_search[sort_column]'] as String?
  ..workSortDirection = json['work_search[sort_direction]'] as String?
  ..peopleQuery = json['people_search[query]'] as String?
  ..peopleName = json['people_search[name]'] as String?
  ..peopleFandom = json['people_search[fandom]'] as String?
  ..tagName = json['tag_search[name]'] as String?
  ..tagFandoms = json['tag_search[fandoms]'] as String?
  ..tagType = json['tag_search[type]'] as String?
  ..tagWranglingStatus = json['tag_search[wrangling_status]'] as String?
  ..tagSortColumn = json['tag_search[sort_column]'] as String?
  ..tagSortDirection = json['tag_search[sort_direction]'] as String?
  ..bookmarkWorkQuery = json['bookmark_search[bookmarkable_query]'] as String?
  ..bookmarkWorkTags = json['bookmark_search[other_tag_names]'] as String?
  ..bookmarkTypes = json['bookmark_search[bookmarkable_type]'] as String?
  ..bookmarkWordCount = json['bookmark_search[word_count]'] as String?
  ..bookmarkLanguage = json['bookmark_search[language_id]'] as String?
  ..bookmarkDateUpdated = json['bookmark_search[bookmarkable_date]'] as String?
  ..bookmarkBookmarkQuery = json['bookmark_search[bookmark_query]'] as String?
  ..bookmarkBookmarkTags =
      json['bookmark_search[other_bookmark_tag_names]'] as String?
  ..bookmarkBookmarker = json['bookmark_search[bookmarker]'] as String?
  ..bookmarkNotes = json['bookmark_search[bookmark_notes]'] as String?
  ..bookmarkRec = json['bookmark_search[rec]'] as bool?
  ..bookmarkWithNotes = json['bookmark_search[with_notes]'] as bool?
  ..bookmarkDateBookmarked = json['bookmark_search[date]'] as String?
  ..bookmarkSortBy = json['bookmark_search[sort_column]'] as String?
  ..commit = json['commit'] as String?
  ..page = json['page'] as String;

Map<String, dynamic> _$ParamMapToJson(ParamMap instance) => <String, dynamic>{
  'work_search[query]': ?instance.workQuery,
  'work_search[title]': ?instance.workTitle,
  'work_search[creators]': ?instance.workCreators,
  'work_search[revised_at]': ?instance.workRevisedAt,
  'work_search[complete]': ?instance.workComplete,
  'work_search[crossover]': ?instance.workCrossover,
  'work_search[language_id]': ?instance.workLanguageId,
  'work_search[rating_ids]': ?instance.workRatingIds,
  'work_search[fandom_names]': ?instance.workFandomNames,
  'work_search[relationship_names]': ?instance.workRelationshipNames,
  'work_search[character_names]': ?instance.workCharacterNames,
  'work_search[archive_warning_ids]': ?instance.workArchiveWarningIds,
  'work_search[category_ids]': ?instance.workCategoryIds,
  'work_search[freeform_names]': ?instance.workFreeformNames,
  'work_search[single_chapter]': ?ParamMap.booleanToIntStringJSON(
    instance.workSingleChapter,
  ),
  'work_search[word_count]': ?instance.workWordCount,
  'work_search[hits]': ?instance.workHits,
  'work_search[kudos_count]': ?instance.workKudosCount,
  'work_search[comments_count]': ?instance.workCommentsCount,
  'work_search[bookmarks_count]': ?instance.workBookmarksCount,
  'work_search[sort_column]': ?instance.workSortColumn,
  'work_search[sort_direction]': ?instance.workSortDirection,
  'people_search[query]': ?instance.peopleQuery,
  'people_search[name]': ?instance.peopleName,
  'people_search[fandom]': ?instance.peopleFandom,
  'tag_search[name]': ?instance.tagName,
  'tag_search[fandoms]': ?instance.tagFandoms,
  'tag_search[type]': ?instance.tagType,
  'tag_search[wrangling_status]': ?instance.tagWranglingStatus,
  'tag_search[sort_column]': ?instance.tagSortColumn,
  'tag_search[sort_direction]': ?instance.tagSortDirection,
  'bookmark_search[bookmarkable_query]': ?instance.bookmarkWorkQuery,
  'bookmark_search[other_tag_names]': ?instance.bookmarkWorkTags,
  'bookmark_search[bookmarkable_type]': ?instance.bookmarkTypes,
  'bookmark_search[word_count]': ?instance.bookmarkWordCount,
  'bookmark_search[language_id]': ?instance.bookmarkLanguage,
  'bookmark_search[bookmarkable_date]': ?instance.bookmarkDateUpdated,
  'bookmark_search[bookmark_query]': ?instance.bookmarkBookmarkQuery,
  'bookmark_search[other_bookmark_tag_names]': ?instance.bookmarkBookmarkTags,
  'bookmark_search[bookmarker]': ?instance.bookmarkBookmarker,
  'bookmark_search[bookmark_notes]': ?instance.bookmarkNotes,
  'bookmark_search[rec]': ?ParamMap.booleanToIntStringJSON(
    instance.bookmarkRec,
  ),
  'bookmark_search[with_notes]': ?ParamMap.booleanToIntStringJSON(
    instance.bookmarkWithNotes,
  ),
  'bookmark_search[date]': ?instance.bookmarkDateBookmarked,
  'bookmark_search[sort_column]': ?instance.bookmarkSortBy,
  'commit': ?instance.commit,
  'page': instance.page,
};
