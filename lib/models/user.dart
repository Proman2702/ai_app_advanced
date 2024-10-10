class CustomUser {
  String username;
  String email;
  List<dynamic> defect;
  Map<dynamic, dynamic> lessons;
  Map<dynamic, dynamic> lessons_correct;
  Map<dynamic, dynamic> time_plan;

  CustomUser(
      {required this.username,
      required this.email,
      required this.defect,
      required this.lessons,
      required this.lessons_correct,
      required this.time_plan});

  CustomUser.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          email: json['email']! as String,
          defect: json['defect']! as List<dynamic>,
          lessons: json['lessons']! as Map<dynamic, dynamic>,
          lessons_correct: json['lessons_correct']! as Map<dynamic, dynamic>,
          time_plan: json['time_plan']! as Map<dynamic, dynamic>,
        );

  CustomUser copyWith(
      {String? username,
      String? email,
      List<dynamic>? defect,
      Map<dynamic, dynamic>? lessons,
      Map<dynamic, dynamic>? lessons_correct,
      Map<dynamic, List<dynamic>>? time_plan}) {
    return CustomUser(
        username: username ?? this.username,
        email: email ?? this.email,
        defect: defect ?? this.defect,
        lessons: lessons ?? this.lessons,
        lessons_correct: lessons_correct ?? this.lessons_correct,
        time_plan: time_plan ?? this.time_plan);
  }

  Map<String, Object?> toJson() {
    return {
      "username": username,
      "email": email,
      "defect": defect,
      "lessons": lessons,
      "lessons_correct": lessons_correct,
      "time_plan": time_plan
    };
  }
}
