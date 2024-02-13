
class Exams{
  Exams({
    required this.examName,
    required this.examID,
    required this.examDate,
    required this.examTime,
    required this.examRoom,
    required this.examDuration,
    this.examDetails,
  });
  final String examName;
  final String examID;
  final DateTime examDate;
  final String examTime;
  final String examRoom;
  final String examDuration;
  final String? examDetails;

  factory Exams.fromJson(Map<String, dynamic> json) => Exams(
    examName: json["examName"],
    examID: json["examID"],
    examDate: DateTime.parse(json["examDate"]),
    examTime: json["examTime"],
    examRoom: json["examRoom"],
    examDuration: json["examDuration"],
    examDetails: json["examDetails"],
  );


  Map<String, dynamic> toJson() => {
    "examName": examName,
    "examID": examID,
    "examDate": examDate.toString(),
    "examTime": examTime,
    "examRoom": examRoom,
    "examDuration": examDuration,
    "examDetails": examDetails,
  };


  //copy with
  Exams copyWith({
    String? examName,
    String? examID,
    DateTime? examDate,
    String? examTime,
    String? examRoom,
    String? examDuration,
    String? examDetails,
  }) =>
      Exams(
        examName: examName ?? this.examName,
        examID: examID ?? this.examID,
        examDate: examDate ?? this.examDate,
        examTime: examTime ?? this.examTime,
        examRoom: examRoom ?? this.examRoom,
        examDuration: examDuration ?? this.examDuration,
        examDetails: examDetails ?? this.examDetails,
      );
}