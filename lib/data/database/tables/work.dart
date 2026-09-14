import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class WorkTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS WORK (
      ID                INTEGER NOT NULL,
      TITLE             TEXT    NOT NULL,
      AUTHOR            TEXT    NOT NULL,
      SUMMARY           TEXT,
      RATING_SYMBOL     TEXT,
      RPO_SYMBOL        TEXT,
      WARNING_SYMBOL    TEXT,
      STATUS_SYMBOL     TEXT,
      LANGUAGE_ID       TEXT,
      PUBLISHED_DATE    DATETIME,
      LAST_UPDATED_DATE DATETIME,
      COMPLETE_DATE     DATETIME,
      CHAPTER_STATS     TEXT,
      WORDS             INTEGER,
      COMMENTS          INTEGER,
      KUDOS             INTEGER,
      BOOKMARKS         INTEGER,
      HITS              INTEGER,
      LAST_FETCHED_DATE DATETIME,
      PARSER_VERSION    INTEGER,
      BOOKMARKED INTEGER DEFAULT (0) NOT NULL,
      CONSTRAINT WORK_PK PRIMARY KEY (ID)
    )
    """,
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}