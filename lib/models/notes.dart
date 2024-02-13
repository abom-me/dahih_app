// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  String? color;
  String? tag;
  String? notes;
  String? id;

  Notes({
    this.color,
    this.tag,
    this.notes,
    this.id,
  });

  Notes copyWith({
    String? color,
    String? tag,
    String? notes,
    String? id,
  }) =>
      Notes(
        color: color ?? this.color,
        tag: tag ?? this.tag,
        notes: notes ?? this.notes,
        id: id ?? this.id,
      );

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    color: json["color"],
    tag: json["tag"],
    notes: json["notes"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "tag": tag,
    "notes": notes,
    "id": id,
  };
}
