import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';
import 'package:ao3_dweller/data/database/tables/chapter.dart';
import 'package:ao3_dweller/data/database/tables/history.dart';
import 'package:ao3_dweller/data/database/tables/library.dart';
import 'package:ao3_dweller/data/database/tables/library_folders.dart';
import 'package:ao3_dweller/data/database/tables/tag.dart';
import 'package:ao3_dweller/data/database/tables/tag_work.dart';
import 'package:ao3_dweller/data/database/tables/work.dart';

class UpgradePath {
  int dbVersion = 1;

  List<Table> tables = [
    HistoryTbl(),
    WorkTbl(),
    ChapterTbl(),
    LibraryFoldersTbl(),
    TagTypesTbl(),
    TagTbl(),
    WorkTagsTbl(),
    LibraryTbl(),
  ];

  List<String> getCreateStmts() {
    List<String> out = [];

    for (Table table in tables) {
      for (String stmt in table.creationStmts) {
        out.add(stmt);
      }
    }

    return out;
  }

  List<String> getUpdateStmts(int oldVersion) {
    List<String> out = [];

    for (Table table in tables) {
      if (table.firstCreationVersion > oldVersion) {
        for (String stmt in table.creationStmts) {
          out.add(stmt);
        }
      }
      else {
        for (UpgradeSet set in table.upgradeSets) {
          if (set.toVersion > oldVersion) {
            for (String stmt in set.statements) {
              out.add(stmt);
            }
          }
        }
      }
    }

    return out;
  }
}