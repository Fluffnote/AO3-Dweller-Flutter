import 'package:ao3_dweller/data/models/chapter.dart';
import 'package:ao3_dweller/data/models/filters/filter.dart';
import 'package:ao3_dweller/data/models/support/auto-entry.dart';
import 'package:ao3_dweller/data/models/work.dart';
import 'package:ao3_dweller/data/network/ClientKeeper.dart';
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



  Future<Document> getSearch(Filter filter) async {
    Document doc =  await getDocFromURI(path: filter.searchBase, params: filter.paramMap().toJson());
    // add parser
    return doc;
  }

  Future<Work> getWork(int workId) async {
    Document doc =  await getDocFromURI(path: "works/$workId", params: {"view_adult": "true"});
    // add parser
    return Work();
  }

  Future<Chapter> getChapter(int workId, int chapterId) async {
    Document doc =  await getDocFromURI(path: "works/$workId/chapters/$chapterId", params: {"view_adult": "true"});
    // add parser
    return Chapter();
  }
}