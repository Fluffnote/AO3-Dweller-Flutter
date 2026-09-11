import 'package:html/dom.dart';
import 'package:talker/talker.dart';

abstract class Parser {
  int version = 0;

  dynamic parse(Node node);
}

class ParserBase {
  Talker talker = Talker();

  void ifClassExists(Element elem, String className, void Function(List<Element> list) fn) {
    if (elem.getElementsByClassName(className).isNotEmpty) {
      try {
        fn(elem.getElementsByClassName(className));
      }
      catch (e, st) {
        talker.handle(e, st);
      }
    }
  }
}