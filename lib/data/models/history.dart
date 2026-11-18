class History {
  int workId = 0;
  int chapterId = 0;
  String workTitle = "";
  String author = "";
  String chapterHeader = "";
  double scrollPosition = 0;
  double scrollMax = 1;
  DateTime accessDate = DateTime.fromMillisecondsSinceEpoch(0);
  bool completed  = false;



  Map<String, Object?> toMap() {
    return {
      "WORK_ID": workId,
      "CHAPTER_ID": chapterId,
      "WORK_TITLE": workTitle,
      "AUTHOR": author,
      "CHAPTER_HEADER": chapterHeader,
      "SCROLL_POSITION": scrollPosition,
      "SCROLL_MAX": scrollMax,
      "ACCESS_DATE": accessDate,
      "COMPLETED": completed?1:0,
    };
  }
}