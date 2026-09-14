import 'package:ao3_dweller/data/database/support/upgrade_set.dart';

class Table {
  int firstCreationVersion = 1;
  List<String> creationStmts = [];
  List<UpgradeSet> upgradeSets = [];
}