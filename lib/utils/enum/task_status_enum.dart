

enum TaskStatusEnum {
  pending("pending"),
  inProgress("inProgress"),
  completed("completed");
  const TaskStatusEnum(this.status);
  final String status;

}