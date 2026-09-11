import 'filters/filter.dart';

class SearchResponse {
  int amountFound = 0;
  Filter? filterUsed;
  List<dynamic> list = [];
  bool searchEnd = false;
}