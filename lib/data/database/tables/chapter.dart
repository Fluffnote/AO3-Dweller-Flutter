import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class ChapterTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS CHAPTER (
      CHAPTER_ID          INTEGER  NOT NULL,
      WORK_ID             INTEGER  NOT NULL,
      NEXT_ID             INTEGER,
      ORDER_NUM           INTEGER,
      WORK_TITLE          TEXT     NOT NULL,
      AUTHOR              TEXT     NOT NULL,
      CHAPTER_LIST_HEADER TEXT,
      CHAPTER_HEADER      TEXT,
      SUMMARY             TEXT,
      NOTES               TEXT,
      END_NOTES           TEXT,
      BODY                TEXT,
      LAST_FETCHED_DATE   DATETIME NOT NULL,
      PARSER_VERSION      INTEGER  NOT NULL,
      CONSTRAINT CHAPTER_WORK_FK FOREIGN KEY (WORK_ID) REFERENCES WORK (ID)
    )
    """,
    "CREATE UNIQUE INDEX IF NOT EXISTS CHAPTER_CHAPTER_UQ_IDX ON CHAPTER (CHAPTER_ID,WORK_ID)",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}