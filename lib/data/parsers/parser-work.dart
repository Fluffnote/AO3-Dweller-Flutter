import 'package:ao3_dweller/data/models/chapter.dart';
import 'package:ao3_dweller/data/models/support/symbols.dart';
import 'package:ao3_dweller/data/models/work.dart';
import 'package:ao3_dweller/data/parsers/parser-chapter.dart';
import 'package:ao3_dweller/data/parsers/parser.dart';
import 'package:html/dom.dart';

class WorkParser extends ParserBase implements Parser {

  @override
  int version = 1;

  @override
  Work parse(Node node) {

    Work out = Work();
    Document doc = node as Document;

    // Setting parse data
    out.lastFetchDate = DateTime.now();
    out.parserVersion = version;



    // ============================
    // Basic info
    // ============================

    // Set ID
    ifClassExists(doc.body!, "share", (List<Element> list){
      String share = list[0].children[0].attributes["href"] as String;
      out.id = int.parse(share.substring(share.indexOf("works/")+6, share.length-6));
    });

    // Set Title
    ifClassExists(doc.body!, "title heading", (List<Element> list){
      out.title = list[0].text.trim();
    });

    // Set Author
    ifClassExists(doc.body!, "byline heading", (List<Element> list){
      out.author = list[0].children[0].text.trim();
    });

    // Set Summary
    ifClassExists(doc.body!, "summary module", (List<Element> list){
      out.summary = list[0].children.last.innerHtml.trim();
    });



    // ============================
    // Tags & info
    // ============================

    // Set Rating
    ifClassExists(doc.body!, "rating tags", (List<Element> list){
      out.rating = list.last.text.trim();
      if (out.rating == "Not Rated") out.ratingSymbol = ContentRating.none;
      if (out.rating == "General Audiences") out.ratingSymbol = ContentRating.general;
      if (out.rating == "Teen And Up Audiences") out.ratingSymbol = ContentRating.teen;
      if (out.rating == "Mature") out.ratingSymbol = ContentRating.mature;
      if (out.rating == "Explicit") out.ratingSymbol = ContentRating.explicit;
    });

    // Set Warning
    ifClassExists(doc.body!, "warning tags", (List<Element> list){
      out.warning = list.last.text.trim();
      if (out.warning.contains("No Archive Warnings Apply")) out.warningSymbol = ContentWarning.none;
      if (out.warning.contains("Chose Not To Use Archive Warnings")) out.warningSymbol = ContentWarning.unspecified;
      if (out.warning.contains("External")) out.warningSymbol = ContentWarning.external;
      if (out.warning.contains("Graphic Depictions Of Violence")) out.warningSymbol = ContentWarning.explicit;
      if (out.warning.contains("Major Character Death")) out.warningSymbol = ContentWarning.explicit;
      if (out.warning.contains("Rape/Non-Con")) out.warningSymbol = ContentWarning.explicit;
      if (out.warning.contains("Underage Sex")) out.warningSymbol = ContentWarning.explicit;
    });

    // Set Categories
    ifClassExists(doc.body!, "category tags", (List<Element> list) {
      for (Element item in list.last.children[0].children) {
        out.categories.add(item.text.trim());
      }
      if (out.categories.contains("No category")) out.rpoSymbol = ContentRPO.none;
      if (out.categories.contains("F/F")) out.rpoSymbol = ContentRPO.ff;
      if (out.categories.contains("M/M")) out.rpoSymbol = ContentRPO.mm;
      if (out.categories.contains("F/M")) out.rpoSymbol = ContentRPO.fm;
      if (out.categories.contains("Gen")) out.rpoSymbol = ContentRPO.gen;
      if (out.categories.contains("Other")) out.rpoSymbol = ContentRPO.other;
      if (out.categories.contains("Multi")) out.rpoSymbol = ContentRPO.multi;
    });

    // Set Fandoms
    ifClassExists(doc.body!, "fandom tags", (List<Element> list) {
      for (Element item in list.last.children[0].children) {
        out.fandoms.add(item.text.trim());
      }
    });

    // Set Relationships
    ifClassExists(doc.body!, "relationship tags", (List<Element> list) {
      for (Element item in list.last.children[0].children) {
        out.relationships.add(item.text.trim());
      }
    });

    // Set Characters
    ifClassExists(doc.body!, "character tags", (List<Element> list) {
      for (Element item in list.last.children[0].children) {
        out.characters.add(item.text.trim());
      }
    });

    // Set Additional Tags
    ifClassExists(doc.body!, "freeform tags", (List<Element> list) {
      for (Element item in list.last.children[0].children) {
        out.freeforms.add(item.text.trim());
      }
    });

    // Set Language
    ifClassExists(doc.body!, "language", (List<Element> list){
      out.language = list.last.text.trim();
    });



    // ============================
    // Stats
    // ============================

    ifClassExists(doc.body!, "stats", (List<Element> list1){
      Element stats = list1.last;

      // Set Published Date
      ifClassExists(stats, "published", (List<Element> list){
        out.publishedDate = DateTime.tryParse(list.last.text.trim());
        if (out.publishedDate != null) out.statusSymbol = ContentStatus.completed;
      });

      // Set Status
      ifClassExists(stats, "status", (List<Element> list){
        // Set Last Updated Date
        out.lastUpdatedDate = DateTime.tryParse(list.last.text.trim());
        if (out.lastUpdatedDate != null) out.statusSymbol = ContentStatus.inProgress;

        // Set Complete Date
        if (list[0].text.contains("Completed")) {
          out.completeDate = DateTime.tryParse(list.last.text.trim());
          if (out.completeDate != null) out.statusSymbol = ContentStatus.completed;
        }
      });

      // Set Chapter Stats
      ifClassExists(stats, "chapters", (List<Element> list){
        out.chapterStats = list.last.text.trim();
      });

      // Set Words
      ifClassExists(stats, "words", (List<Element> list){
        out.words = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });

      // Set Comments
      ifClassExists(stats, "comments", (List<Element> list){
        out.comments = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });

      // Set Kudos
      ifClassExists(stats, "kudos", (List<Element> list){
        out.kudos = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });

      // Set Bookmarks
      ifClassExists(stats, "bookmarks", (List<Element> list){
        out.bookmarks = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });

      // Set Hits
      ifClassExists(stats, "hits", (List<Element> list){
        out.hits = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });
    });



    // ============================
    // Chapter(s) setup
    // ============================
    
    if (doc.getElementById("selected_id") != null) { // Multi chapter
      List<Element> list = doc.getElementById("selected_id")!.children;

      for (int i = 0; i < list.length; i++) {
        Chapter chap = Chapter();
        if (i == 0) { // Parsing first chapter to cut down on network calls
          chap = ChapterParser().parse(doc);
        }
        chap.id = int.parse(list[i].attributes["value"]!);
        chap.workId = out.id;
        chap.chapterListHeader = list[i].text.trim();
        chap.order = i + 1;
        if (i < list.length - 1) chap.nextId = int.parse(list[i+1].attributes["value"]!);
        out.chapters.add(chap);
      }
    }
    else { // One-shot
      Chapter chap = Chapter();
      chap = ChapterParser().parse(doc);
      chap.id = 0;
      chap.workId = out.id;
      chap.chapterListHeader = out.title;
      chap.order = 1;
      out.chapters.add(chap);
    }



    return out;
  }

}