import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class CustomUser with _$CustomUser {
  const factory CustomUser({
    required String username,
    required String email,
    @Default(<String, int>{}) Map<String, int> defects,
    @JsonKey(name: 'lessons_passed') @Default(<String, int>{}) Map<String, int> lessonsPassed,
    @JsonKey(name: 'lessons_correct') @Default(<String, int>{}) Map<String, int> lessonsCorrect,
    @JsonKey(name: 'current_level') @Default(<String, int>{}) Map<String, int> currentLevel,
    @JsonKey(name: 'current_combo') @Default(<String, int>{}) Map<String, int> currentCombo,
  }) = _CustomUser;

  factory CustomUser.fromJson(Map<String, dynamic> json) => _$CustomUserFromJson(json);
}
