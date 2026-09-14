import 'package:ao3_dweller/data/models/chapter.dart';
import 'package:ao3_dweller/data/models/filters/filter.dart';
import 'package:ao3_dweller/data/models/filters/filter_work.dart';
import 'package:ao3_dweller/data/models/search.dart';
import 'package:ao3_dweller/data/models/support/auto_entry.dart';
import 'package:ao3_dweller/data/models/work.dart';
import 'package:ao3_dweller/data/network/client_keeper.dart';
import 'package:ao3_dweller/data/parsers/parser_chapter.dart';
import 'package:ao3_dweller/data/parsers/parser_search_works.dart';
import 'package:ao3_dweller/data/parsers/parser_work.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class API {

  String scheme = "https";
  String host = "archiveofourown.org";


  Future<List<AutocompleteEntry>> getAutocomplete(String section, String query) async {
    Uri uri = Uri(
        scheme: scheme, host: host,
        path: 'autocomplete/$section',
        queryParameters: {'term': query}
    );
    Response response = await(await ClientKeeper.instance.JSONClient).getUri(uri);
    return List<AutocompleteEntry>.from(response.data.map((model)=> AutocompleteEntry.fromJson(model)));
  }

  Future<Document> getDocFromURI({required String path, Map<String, dynamic>? params}) async {
    Uri uri = Uri(
        scheme: scheme, host: host,
        path: path, queryParameters: params
    );
    Response response = await(await ClientKeeper.instance.client).getUri(uri);
    return parse(response.data);
  }



  Future<SearchResponse> getSearch(Filter filter, SearchResponse? sr) async {
    Document doc =  await getDocFromURI(path: filter.searchBase, params: filter.paramMap().toJson());
    SearchResponse out = SearchResponse();
    if (filter.runtimeType == WorkFilter) out = WorksSearchParser(filter, sr).parse(doc); // Works Search
    // People Search (to-do)
    // Tags Search (to-do)
    // Bookmarks Search (to-do)
    return out;
  }

  Future<Work> getWork(int workId) async {
    Document doc =  await getDocFromURI(path: "works/$workId", params: {"view_adult": "true"});
    return WorkParser().parse(doc);
  }

  Future<Chapter> getChapter(int workId, int chapterId) async {
    Document doc =  await getDocFromURI(path: "works/$workId/chapters/$chapterId", params: {"view_adult": "true"});
    return ChapterParser().parse(doc);
  }
}