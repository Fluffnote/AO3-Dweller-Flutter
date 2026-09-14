import 'package:ao3_dweller/data/models/chapter.dart';
import 'package:ao3_dweller/data/parsers/parser.dart';
import 'package:html/dom.dart';

class ChapterParser extends ParserBase implements Parser {

  @override
  int version = 1;

  @override
  Chapter parse(Node node) {

    Chapter out = Chapter();
    Document doc = node as Document;

    // Setting parse data
    out.lastFetchDate = DateTime.now();
    out.parserVersion = version;



    // ============================
    // Basic info
    // ============================

    // Set ID
    ifClassExists(doc.body!, "chapter preface group", (List<Element> list){
      String chapterLink = list[0].children[0].children[0].attributes["href"] as String;
      out.id = int.parse(chapterLink.substring(chapterLink.indexOf("chapters/")+9));
    });

    // Set Work ID
    ifClassExists(doc.body!, "share", (List<Element> list){
      String share = list[0].children[0].attributes["href"] as String;
      out.workId = int.parse(share.substring(share.indexOf("works/")+6, share.length-6));
    });

    // Set Next ID
    ifClassExists(doc.body!, "chapter next", (List<Element> list){
      String next = list[0].children[0].attributes["href"] as String;
      out.nextId = int.parse(next.substring(next.indexOf("chapters/")+9, next.indexOf("#")));
    });



    // ============================
    // Main info
    // ============================

    // Set Chapter Header
    ifClassExists(doc.body!, "chapter preface group", (List<Element> list){
      String title = list[0].children[0].children[0].text;
      out.chapterHeader = title.trim();
    });

    // Set Summary
    ifClassExists(doc.body!, "summary module", (List<Element> list){
      out.summary = list[0].children.last.innerHtml.trim();
    });

    // Set Notes
    ifClassExists(doc.body!, "notes module", (List<Element> list){
      for (Element item in list) {
        Element content = item.querySelector(".userstuff") ?? item;
        if (item.classes.contains("end")) {
          // End notes
          out.endNotes.add(content.innerHtml.trim());
        }
        else {
          // Start notes
          out.notes.add(content.innerHtml.trim());
        }
      }
    });

    // Set Body
    ifClassExists(doc.body!, "userstuff module", (List<Element> list){
      out.body = list[0].innerHtml.replaceAll(RegExp(r'<h3 class="landmark heading" id="work">.*<\/h3>'),"").trim();
    });

    if (out.body.length == 0) {
      if (doc.getElementById("chapters") != null) {
        ifClassExists(doc.getElementById("chapters")!, "userstuff", (List<Element> list){
          out.body = list[0].innerHtml.replaceAll(RegExp(r'<h3 class="landmark heading" id="work">.*<\/h3>'),"").trim();
        });
      }
    }



    // ============================
    // Main info
    // ============================

    // Set Title
    ifClassExists(doc.body!, "title heading", (List<Element> list){
      out.workTitle = list[0].text.trim();
    });

    // Set Author
    ifClassExists(doc.body!, "byline heading", (List<Element> list){
      out.author = list[0].children[0].text.trim();
    });


    return out;
  }
}