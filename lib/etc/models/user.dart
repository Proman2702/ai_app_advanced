class CustomUser {
  String username;
  String email;
  Map<dynamic, dynamic> defects;
  Map<dynamic, dynamic> lessons_passed;
  Map<dynamic, dynamic> lessons_correct;
  Map<dynamic, dynamic> current_level;
  Map<dynamic, dynamic> current_combo;

  CustomUser(
      {required this.username,
      required this.email,
      required this.defects,
      required this.lessons_passed,
      required this.lessons_correct,
      required this.current_level,
      required this.current_combo});

  CustomUser.fromJson(Map<String, Object?> json)
      : this(
            username: json['username']! as String,
            email: json['email']! as String,
            defects: json['defects']! as Map<dynamic, dynamic>,
            lessons_passed: json['lessons_passed']! as Map<dynamic, dynamic>,
            lessons_correct: json['lessons_correct']! as Map<dynamic, dynamic>,
            current_level: json['current_level']! as Map<dynamic, dynamic>,
            current_combo: json['current_combo']! as Map<dynamic, dynamic>);

  CustomUser copyWith(
      {String? username,
      String? email,
      Map<dynamic, dynamic>? defects,
      Map<dynamic, dynamic>? lessons_passed,
      Map<dynamic, dynamic>? lessons_correct,
      Map<dynamic, dynamic>? current_level,
      Map<dynamic, dynamic>? current_combo}) {
    return CustomUser(
        username: username ?? this.username,
        email: email ?? this.email,
        defects: defects ?? this.defects,
        lessons_passed: lessons_passed ?? this.lessons_passed,
        lessons_correct: lessons_correct ?? this.lessons_correct,
        current_level: current_level ?? this.current_level,
        current_combo: current_combo ?? this.current_combo);
  }

  Map<String, Object?> toJson() {
    return {
      "username": username,
      "email": email,
      "defects": defects,
      "lessons_passed": lessons_passed,
      "lessons_correct": lessons_correct,
      "current_level": current_level,
      "current_combo": current_combo,
    };
  }
}
