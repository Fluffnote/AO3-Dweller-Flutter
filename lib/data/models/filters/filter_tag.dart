import 'package:ao3_dweller/data/models/support/param_map.dart';

import '../support/search_options.dart';
import 'filter.dart';

class TagFilter implements Filter{
  @override
  String searchBase = "tags/search";
  @override
  String searchCommit = "Search Tags";

  String query = "";
  List<String> fandoms = [];
  TagTypes type = TagTypes.any;
  TagWrangling wranglingStatus = TagWrangling.any;
  SortColumnTags sortColumn = SortColumnTags.name;
  SortDirection sortDirection = SortDirection.asc;

  @override
  void copyFrom(Filter input) {
    if (input.runtimeType == TagFilter) {
      TagFilter temp = input as TagFilter;

      query = temp.query;
      fandoms = temp.fandoms;
      type = temp.type;
      wranglingStatus = temp.wranglingStatus;
      sortColumn = temp.sortColumn;
      sortDirection = temp.sortDirection;
    }
  }

  @override
  ParamMap paramMap() {
    ParamMap out = ParamMap();

    out.tagName = query;
    out.tagFandoms = fandoms.join(",");
    out.tagType = type.code;
    out.tagWranglingStatus = wranglingStatus.code;
    out.tagSortColumn = sortColumn.code;
    out.tagSortDirection = sortDirection.code;

    out.commit = searchCommit;

    return out;
  }
  
}