import 'package:ao3_dweller/data/database/support/table.dart';
import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class TagTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS TAG (
      ID       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      TAG      TEXT    NOT NULL,
      TAG_TYPE INTEGER NOT NULL,
      CONSTRAINT TAG_TAG_TYPES_FK FOREIGN KEY (TAG_TYPE) REFERENCES TAG_TYPES (ID)
    )
    """,
    "CREATE UNIQUE INDEX IF NOT EXISTS TAG_TAG_IDX ON TAG (TAG,TAG_TYPE)",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}

class TagTypesTbl extends Table {

  @override
  int firstCreationVersion = 1;

  @override
  List<String> creationStmts = [
    """
    CREATE TABLE IF NOT EXISTS TAG_TYPES (
      ID   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      NAME TEXT    NOT NULL
    )
    """,
    "INSERT INTO TAG_TYPES (ID, NAME) VALUES (1, 'ANY'), (2, 'RATING'), (3, 'WARNING'), (4, 'CATEGORY'), (5, 'FANDOM'), (6, 'RELATIONSHIP'), (7, 'CHARACTER'), (8, 'FREEFORM')",
  ];

  @override
  List<UpgradeSet> upgradeSets = [

  ];
}