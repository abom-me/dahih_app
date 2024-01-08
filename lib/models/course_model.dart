
import 'package:flutter/material.dart';

class Course{
  final String? name;
  final String? description;
  final String? room;
  final String? teacher;
  final String? from;
  final String? to;
  final List<String>? days;
  final String? id;
  final String? color;
  Course({
    this.name,
    this.description,
    this.room,
    this.teacher,
    this.from,
    this.to,
    this.days,
    this.id,
    this.color,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      description: json['description'],
      room: json['room'],
      teacher: json['teacher'],
      from: json['from'],
      to: json['to'],
      days: json['days'] != null ? List<String>.from(json['days']) : null,
      id: json['id'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'room': room,
      'teacher': teacher,
      'from': from,
      'to': to,
      'days': days,
      'id': id,
      'color': color,
    };
  }
}