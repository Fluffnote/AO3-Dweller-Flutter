import 'package:ao3_dweller/data/models/support/param-map.dart';

abstract class Filter {
  String searchBase = "";
  String searchCommit = "";

  void copyFrom(Filter input);
  ParamMap paramMap();
}

class TagSet {
  List<String> mustHaveTags = [];
  List<String> canHaveTags = [];
  List<String> excludeTags = [];
}

