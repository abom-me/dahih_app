
class Tasks{
  final String task;
  final String? description;
  final DateTime? date;
  final int? time;
  final int? duration;
  final String? status;
  final String? category;
  final String? id;

  Tasks( {required this.task, this.description, this.date, this.time, this.duration,this.status,this.category, this.id});

  factory Tasks.fromJson(Map<String, dynamic> json){
    return Tasks(
      task: json['task'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      duration: json['duration'],
      status: json['status'],
      category: json['category'],
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() => {
    'task': task,
    'description': description,
    'date': date,
    'time': time,
    'duration': duration,
    'status': status,
    'category': category,
    'id': id
  };

}