import 'package:json_annotation/json_annotation.dart';

part 'auto_entry.g.dart';

@JsonSerializable()
class AutocompleteEntry {
  @JsonKey()
  String id = "";
  @JsonKey()
  String name = "";

  AutocompleteEntry({required this.id, required this.name});

  factory AutocompleteEntry.fromJson(Map<String, dynamic> json) => _$AutocompleteEntryFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteEntryToJson(this);
}