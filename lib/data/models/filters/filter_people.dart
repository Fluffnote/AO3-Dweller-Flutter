import 'package:ao3_dweller/data/models/support/param_map.dart';

import 'filter.dart';

class PeopleFilter implements Filter {
  @override
  String searchBase = "people/search";
  @override
  String searchCommit = "Search People";

  String query = "";
  List<String> names = [];
  List<String> fandoms = [];

  @override
  void copyFrom(Filter input) {
    if (input.runtimeType == PeopleFilter) {
      query = (input as PeopleFilter).query;
      names = (input as PeopleFilter).names;
      fandoms = (input as PeopleFilter).fandoms;
    }
  }

  @override
  ParamMap paramMap() {
    ParamMap out = ParamMap();

    out.peopleQuery = query;
    out.peopleName = names.join(",");
    out.peopleFandom = fandoms.join(",");

    out.commit = searchCommit;

    return out;
  }
  
}