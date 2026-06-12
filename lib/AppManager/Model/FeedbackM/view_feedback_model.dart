class ViewFeedbackModel {
  final int id;
  final int studentId;
  final String title;
  final String description;
  final String? remark;
  final String? repliedBy;
  final int status;
  final String createdDate;

  ViewFeedbackModel({
    required this.id,
    required this.studentId,
    required this.title,
    required this.description,
    this.remark,
    this.repliedBy,
    required this.status,
    required this.createdDate,
  });

  factory ViewFeedbackModel.fromJson(Map<String, dynamic> json) {
    return ViewFeedbackModel(
      id: json["id"] ?? 0,
      studentId: json["studentId"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      remark: json["remark"],
      repliedBy: json["repliedBy"],
      status: json["status"] ?? 0,
      createdDate: json["createdDate"] ?? "",
    );
  }
}