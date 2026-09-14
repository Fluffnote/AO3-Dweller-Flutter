import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class HistoryTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS HISTORY (
      WORK_ID        INTEGER  NOT NULL,
      CHAPTER_ID     INTEGER  NOT NULL,
      WORK_TITLE     TEXT,
      AUTHOR         TEXT,
      CHAPTER_HEADER TEXT,
      SCROLL_POSITION DOUBLE,
      SCROLL_MAX     DOUBLE,
      ACCESS_DATE    DATETIME NOT NULL,
      COMPLETED INTEGER DEFAULT (0) NOT NULL
    )
    """,
    "CREATE UNIQUE INDEX IF NOT EXISTS HISTORY_WORK_ID_IDX ON HISTORY (WORK_ID,CHAPTER_ID)",
    "CREATE INDEX IF NOT EXISTS HISTORY_ACCESS_DATE_IDX ON HISTORY (ACCESS_DATE)",
    "CREATE INDEX IF NOT EXISTS HISTORY_COMPLETED_IDX ON HISTORY (COMPLETED)",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}