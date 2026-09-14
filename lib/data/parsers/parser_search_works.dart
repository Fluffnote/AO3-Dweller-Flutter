import 'package:ao3_dweller/data/models/filters/filter.dart';
import 'package:ao3_dweller/data/models/search.dart';
import 'package:ao3_dweller/data/models/work.dart';
import 'package:ao3_dweller/data/parsers/parser.dart';
import 'package:html/dom.dart';
import 'package:intl/intl.dart';

import '../models/support/symbols.dart';

class WorksSearchParser extends ParserBase implements Parser {
  @override
  int version = 1;

  Filter? filter;
  SearchResponse? sr;

  WorksSearchParser(this.filter, this.sr);

  @override
  SearchResponse parse(Node node) {

    SearchResponse out;
    Document doc = node as Document;

    if (sr == null) { // New search
      out = SearchResponse();
      out.filterUsed = filter;

      // Get Amount Found
      if (doc.getElementById("main") != null) {
        Element found = doc.getElementById("main")!.children[4];
        out.amountFound = int.parse(found.text.replaceAll(RegExp(r'\D'), ""));
      }
    }
    else { // Adding works to list (infinite load)
      out = sr!;

      if (out.searchEnd) return out;
    }



    // Add Works
    ifClassExists(doc.body!, "work index group", (lists) {
      for (Element part in lists[0].children) {
        out.list.add(WorksSearchParserWorkPart().parse(part));
      }
    });

    // Check if end
    if (out.list.length == out.amountFound) out.searchEnd = true;

    return out;
  }

}

class WorksSearchParserWorkPart extends ParserBase implements Parser {
  @override
  int version = 1;

  @override
  Work parse(Node node) {

    Work out = Work();
    Element part = node as Element;

    // Setting parse data
    out.parserVersion = version;



    // ============================
    // Basic info
    // ============================

    // Set ID
    out.id = int.parse(part.id.substring(part.id.indexOf("work_")+5));

    // Set Title & Author
    ifClassExists(part, "header module", (list) {
      String header = list[0].children[0].text.trim();
      header = header.replaceAll(RegExp(r'[\n\r]'), "").replaceAll(RegExp(r'[\s\t\n\r]*by[\s\t\n\r]*'), " by ");
      // header = header.replace(/[\n\r]/g, "").replace(/[\s\t\n\r]*by[\s\t\n\r]*/g, " by ");
      out.title = header.substring(0, header.indexOf(" by "));
      out.author = header.substring(header.indexOf(" by ")+4);
    });

    // Set Summary
    ifClassExists(part, "userstuff summary", (list) {
      out.summary = list[0].innerHtml.trim();
    });



    // ============================
    // Tags & info
    // ============================

    // Set Symbols
    ifClassExists(part, "required-tags", (listSy) {
      Element tags = listSy[0];

      // Set Rating Symbol
      ifClassExists(tags, "rating", (list) {
        String rating = list[0].text.trim();
        if (rating == "Not Rated") out.ratingSymbol = ContentRating.none;
        if (rating == "General Audiences") out.ratingSymbol = ContentRating.general;
        if (rating == "Teen And Up Audiences") out.ratingSymbol = ContentRating.teen;
        if (rating == "Mature") out.ratingSymbol = ContentRating.mature;
        if (rating == "Explicit") out.ratingSymbol = ContentRating.explicit;
      });

      // Set RPO Symbol
      ifClassExists(tags, "category", (list) {
        String rpo = list[0].text.trim();
        if (rpo.contains("No category")) out.rpoSymbol = ContentRPO.none;
        if (rpo.contains("F/F")) out.rpoSymbol = ContentRPO.ff;
        if (rpo.contains("M/M")) out.rpoSymbol = ContentRPO.mm;
        if (rpo.contains("F/M")) out.rpoSymbol = ContentRPO.fm;
        if (rpo.contains("Gen")) out.rpoSymbol = ContentRPO.gen;
        if (rpo.contains("Other")) out.rpoSymbol = ContentRPO.other;
        if (rpo.contains("Multi")) out.rpoSymbol = ContentRPO.multi;
      });

      // Set Warning Symbol
      ifClassExists(tags, "warnings", (list) {
        String warning = list[0].text.trim();
        if (warning.contains("No Archive Warnings Apply")) out.warningSymbol = ContentWarning.none;
        if (warning.contains("Chose Not To Use Archive Warnings")) out.warningSymbol = ContentWarning.unspecified;
        if (warning.contains("External")) out.warningSymbol = ContentWarning.external;
        if (warning.contains("Graphic Depictions Of Violence")) out.warningSymbol = ContentWarning.explicit;
        if (warning.contains("Major Character Death")) out.warningSymbol = ContentWarning.explicit;
        if (warning.contains("Rape/Non-Con")) out.warningSymbol = ContentWarning.explicit;
        if (warning.contains("Underage Sex")) out.warningSymbol = ContentWarning.explicit;
      });

      // Set Status Symbol
      ifClassExists(tags, "iswip", (list) {
        String status = list[0].text.trim();
        if (status.contains("Work in Progress")) out.statusSymbol = ContentStatus.inProgress;
        if (status.contains("Complete Work")) out.statusSymbol = ContentStatus.completed;
      });
    });

    // Set Fandoms
    ifClassExists(part, "fandoms heading", (list) {
      for (Element fandom in list[0].children) {
        if (fandom.text.trim() == "Fandoms:") continue;
        out.fandoms.add(fandom.text.trim());
      }
    });
    
    // Set Additional Tags
    ifClassExists(part, "tags commas", (list) {
      Element ul = list[0];
  
      // Set Warning Tag
      ifClassExists(ul, "warnings", (list) {
        out.warning = list[0].text.trim();
      });
      
      // Set Relationship Tags
      ifClassExists(ul, "relationships", (list) {
        for (Element tag in list) {
          out.relationships.add(tag.text.trim());
        }
      });
      
      // Set Character Tags
      ifClassExists(ul, "characters", (list) {
        for (Element tag in list) {
          out.characters.add(tag.text.trim());
        }
      });
      
      // Set Freeform Tags
      ifClassExists(ul, "freeforms", (list) {
        for (Element tag in list) {
          out.freeforms.add(tag.text.trim());
        }
      });
    });
    
    // Set Last Updated Date
    ifClassExists(part, "datetime", (list) {
      out.lastUpdatedDate = DateFormat("d MMM y").parse(list[0].text.trim());
      // out.lastUpdatedDate = new Date((list[0] as HTMLParagraphElement).text.trim());
    });



    // ============================
    // Language & Stats
    // ============================

    ifClassExists(part, "stats", (list) {
      Element stats = list.last;

      // Set Language
      ifClassExists(stats, "language", (list) {
        out.language = list.last.text.trim();
      });
      
      // Set Chapter Stats
      ifClassExists(stats, "chapters", (list) {
        out.chapterStats = list.last.text.trim();
      });
      
      // Set Words
      ifClassExists(stats, "words", (list) {
        out.words = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });
      
      // Set Comments
      ifClassExists(stats, "comments", (list) {
        out.comments = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });
      
      // Set Kudos
      ifClassExists(stats, "kudos", (list) {
        out.kudos = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });
      
      // Set Bookmarks
      ifClassExists(stats, "bookmarks", (list) {
        out.bookmarks = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });
      
      // Set Hits
      ifClassExists(stats, "hits", (list) {
        out.hits = int.parse(list.last.text.replaceAll(RegExp(r'\D'), ""));
      });
    });



    return out;
  }

}