import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class WorkTagsTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS WORK_TAGS (
      WORK_ID INTEGER NOT NULL,
      TAG_ID  INTEGER NOT NULL,
      CONSTRAINT WORK_TAGS_WORK_FK FOREIGN KEY (WORK_ID) REFERENCES WORK (ID),
      CONSTRAINT WORK_TAGS_TAG_FK FOREIGN KEY (TAG_ID) REFERENCES TAG (ID)
    )
    """,
    "CREATE UNIQUE INDEX IF NOT EXISTS WORK_TAGS_WORK_ID_IDX ON WORK_TAGS (WORK_ID,TAG_ID)",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}