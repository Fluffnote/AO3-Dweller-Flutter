import 'package:flutter/material.dart';

enum ContentRating(final AssetImage image) {
  none(AssetImage("assets/symbols/none.png")),
  general(AssetImage("assets/symbols/rating/rating-general-audience.png")),
  teen(AssetImage("assets/symbols/rating/rating-teen.png")),
  mature(AssetImage("assets/symbols/rating/rating-mature.png")),
  explicit(AssetImage("assets/symbols/rating/rating-explicit.png"));
}



enum ContentRPO(final AssetImage image) {
  none(AssetImage("assets/symbols/none.png")),
  ff(AssetImage("assets/symbols/RPO/category-femslash.png")),
  fm(AssetImage("assets/symbols/RPO/category-het.png")),
  gen(AssetImage("assets/symbols/RPO/category-gen.png")),
  mm(AssetImage("assets/symbols/RPO/category-slash.png")),
  multi(AssetImage("assets/symbols/RPO/category-multi.png")),
  other(AssetImage("assets/symbols/RPO/category-other.png"));
}



enum ContentWarning(final AssetImage image) {
  none(AssetImage("assets/symbols/none.png")),
  unspecified(AssetImage("assets/symbols/warning/warning-choosenotto.png")),
  explicit(AssetImage("assets/symbols/warning/warning-yes.png")),
  external(AssetImage("assets/symbols/warning/warning-external-work.png"));
}



enum ContentStatus(final AssetImage image) {
  unknown(AssetImage("assets/symbols/none.png")),
  inProgress(AssetImage("assets/symbols/status/complete-no.png")),
  completed(AssetImage("assets/symbols/status/complete-yes.png"));
}