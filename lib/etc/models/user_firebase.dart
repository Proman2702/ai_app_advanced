import 'user.dart';

CustomUser customUserFromFirestore(Map<String, dynamic> raw) {
  final fixed = <String, dynamic>{
    ...raw,
    'defects': _normalizeIntMap(raw['defects']),
    'lessons_passed': _normalizeIntMap(raw['lessons_passed']),
    'lessons_correct': _normalizeIntMap(raw['lessons_correct']),
    'current_level': _normalizeIntMap(raw['current_level']),
    'current_combo': _normalizeIntMap(raw['current_combo']),
  };

  return CustomUser.fromJson(fixed);
}

Map<String, dynamic> customUserToFirestore(CustomUser user) {
  return user.toJson();
}

Map<String, dynamic> _normalizeIntMap(Object? value) {
  if (value == null) return <String, dynamic>{};
  if (value is! Map) return <String, dynamic>{};

  final out = <String, dynamic>{};
  value.forEach((k, v) {
    out[k.toString()] = _toInt(v);
  });
  return out;
}

int _toInt(Object? v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}
