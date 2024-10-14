class CustomUser {
  String username;
  String email;
  List<dynamic> defect;
  Map<dynamic, dynamic> lessons_passed;
  Map<dynamic, dynamic> lessons_correct;
  Map<dynamic, dynamic> time_plan;
  Map<dynamic, dynamic> lessons;
  bool isDiagnosed;
  bool isRedacted;

  CustomUser(
      {required this.username,
      required this.email,
      required this.defect,
      required this.lessons_passed,
      required this.lessons_correct,
      required this.time_plan,
      required this.lessons,
      required this.isDiagnosed,
      required this.isRedacted});

  CustomUser.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          email: json['email']! as String,
          defect: json['defect']! as List<dynamic>,
          lessons_passed: json['lessons_passed']! as Map<dynamic, dynamic>,
          lessons_correct: json['lessons_correct']! as Map<dynamic, dynamic>,
          time_plan: json['time_plan']! as Map<dynamic, dynamic>,
          lessons: json['lessons']! as Map<dynamic, dynamic>,
          isDiagnosed: json['isDiagnosed']! as bool,
          isRedacted: json['isRedacted']! as bool,
        );

  CustomUser copyWith(
      {String? username,
      String? email,
      List<dynamic>? defect,
      Map<dynamic, dynamic>? lessons_passed,
      Map<dynamic, dynamic>? lessons_correct,
      Map<dynamic, dynamic>? time_plan,
      Map<dynamic, dynamic>? lessons,
      bool? isDiagnosed,
      bool? isRedacted}) {

    return CustomUser(
        username: username ?? this.username,
        email: email ?? this.email,
        defect: defect ?? this.defect,
        lessons_passed: lessons_passed ?? this.lessons_passed,
        lessons_correct: lessons_correct ?? this.lessons_correct,
        time_plan: time_plan ?? this.time_plan,
        lessons: lessons ?? this.lessons,
        isDiagnosed: isDiagnosed ?? this.isDiagnosed,
        isRedacted: isRedacted ?? this.isRedacted);
  }

  Map<String, Object?> toJson() {
    return {
      "username": username,
      "email": email,
      "defect": defect,
      "lessons_passed": lessons_passed,
      "lessons_correct": lessons_correct,
      "time_plan": time_plan,
      "lessons": lessons,
      "isDiagnosed": isDiagnosed,
      "isRedacted": isRedacted
    };
  }
}
