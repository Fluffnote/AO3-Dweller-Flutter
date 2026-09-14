import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class LibraryTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS LIBRARY (
      WORK_ID   INTEGER NOT NULL,
      FOLDER_ID INTEGER NOT NULL,
      ORDER_NUM   INTEGER NOT NULL,
      DATE_ADDED DATETIME NOT NULL,
      CONSTRAINT LIBRARY_WORK_FK FOREIGN KEY (WORK_ID) REFERENCES WORK (ID),
      CONSTRAINT LIBRARY_LIBRARY_FOLDERS_FK FOREIGN KEY (FOLDER_ID) REFERENCES LIBRARY_FOLDERS (ID)
    )
    """,
    "CREATE UNIQUE INDEX IF NOT EXISTS LIBRARY_WORK_ID_IDX ON LIBRARY (WORK_ID,FOLDER_ID)",
    "CREATE INDEX IF NOT EXISTS LIBRARY_DATE_ADDED_IDX ON LIBRARY (DATE_ADDED)",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}