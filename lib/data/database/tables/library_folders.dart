import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class LibraryFoldersTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS LIBRARY_FOLDERS (
      ID        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      NAME      TEXT    NOT NULL,
      ORDER_NUM INTEGER NOT NULL,
      PARENT_ID INTEGER,
      DATE_ADDED DATETIME NOT NULL,
      CONSTRAINT LIBRARY_FOLDERS_LIBRARY_FOLDERS_FK FOREIGN KEY (PARENT_ID) REFERENCES LIBRARY_FOLDERS (ID)
    )
    """,
    "CREATE INDEX IF NOT EXISTS LIBRARY_FOLDERS_DATE_ADDED_IDX ON LIBRARY_FOLDERS (DATE_ADDED)",
    "INSERT INTO LIBRARY_FOLDERS (ID, NAME, ORDER_NUM, PARENT_ID, DATE_ADDED) VALUES(1, 'ROOT', 0, NULL, datetime('now'))",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}