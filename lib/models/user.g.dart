// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomUser _$CustomUserFromJson(Map<String, dynamic> json) => _CustomUser(
      username: json['username'] as String,
      email: json['email'] as String,
      defects: (json['defects'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      lessonsPassed: (json['lessonsPassed'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      lessonsCorrect: (json['lessonsCorrect'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      currentLevel: (json['currentLevel'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      currentCombo: (json['currentCombo'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
    );

Map<String, dynamic> _$CustomUserToJson(_CustomUser instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'defects': instance.defects,
      'lessonsPassed': instance.lessonsPassed,
      'lessonsCorrect': instance.lessonsCorrect,
      'currentLevel': instance.currentLevel,
      'currentCombo': instance.currentCombo,
    };
