// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomUser {
  String get username;
  String get email;
  Map<String, int> get defects;
  Map<String, int> get lessonsPassed;
  Map<String, int> get lessonsCorrect;
  Map<String, int> get currentLevel;
  Map<String, int> get currentCombo;

  /// Create a copy of CustomUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUserCopyWith<CustomUser> get copyWith =>
      _$CustomUserCopyWithImpl<CustomUser>(this as CustomUser, _$identity);

  /// Serializes this CustomUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUser &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other.defects, defects) &&
            const DeepCollectionEquality()
                .equals(other.lessonsPassed, lessonsPassed) &&
            const DeepCollectionEquality()
                .equals(other.lessonsCorrect, lessonsCorrect) &&
            const DeepCollectionEquality()
                .equals(other.currentLevel, currentLevel) &&
            const DeepCollectionEquality()
                .equals(other.currentCombo, currentCombo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      email,
      const DeepCollectionEquality().hash(defects),
      const DeepCollectionEquality().hash(lessonsPassed),
      const DeepCollectionEquality().hash(lessonsCorrect),
      const DeepCollectionEquality().hash(currentLevel),
      const DeepCollectionEquality().hash(currentCombo));

  @override
  String toString() {
    return 'CustomUser(username: $username, email: $email, defects: $defects, lessonsPassed: $lessonsPassed, lessonsCorrect: $lessonsCorrect, currentLevel: $currentLevel, currentCombo: $currentCombo)';
  }
}

/// @nodoc
abstract mixin class $CustomUserCopyWith<$Res> {
  factory $CustomUserCopyWith(
          CustomUser value, $Res Function(CustomUser) _then) =
      _$CustomUserCopyWithImpl;
  @useResult
  $Res call(
      {String username,
      String email,
      Map<String, int> defects,
      Map<String, int> lessonsPassed,
      Map<String, int> lessonsCorrect,
      Map<String, int> currentLevel,
      Map<String, int> currentCombo});
}

/// @nodoc
class _$CustomUserCopyWithImpl<$Res> implements $CustomUserCopyWith<$Res> {
  _$CustomUserCopyWithImpl(this._self, this._then);

  final CustomUser _self;
  final $Res Function(CustomUser) _then;

  /// Create a copy of CustomUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? defects = null,
    Object? lessonsPassed = null,
    Object? lessonsCorrect = null,
    Object? currentLevel = null,
    Object? currentCombo = null,
  }) {
    return _then(_self.copyWith(
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      defects: null == defects
          ? _self.defects
          : defects // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lessonsPassed: null == lessonsPassed
          ? _self.lessonsPassed
          : lessonsPassed // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lessonsCorrect: null == lessonsCorrect
          ? _self.lessonsCorrect
          : lessonsCorrect // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      currentLevel: null == currentLevel
          ? _self.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      currentCombo: null == currentCombo
          ? _self.currentCombo
          : currentCombo // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomUser].
extension CustomUserPatterns on CustomUser {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CustomUser value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUser() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CustomUser value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomUser():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CustomUser value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomUser() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String username,
            String email,
            Map<String, int> defects,
            Map<String, int> lessonsPassed,
            Map<String, int> lessonsCorrect,
            Map<String, int> currentLevel,
            Map<String, int> currentCombo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUser() when $default != null:
        return $default(
            _that.username,
            _that.email,
            _that.defects,
            _that.lessonsPassed,
            _that.lessonsCorrect,
            _that.currentLevel,
            _that.currentCombo);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String username,
            String email,
            Map<String, int> defects,
            Map<String, int> lessonsPassed,
            Map<String, int> lessonsCorrect,
            Map<String, int> currentLevel,
            Map<String, int> currentCombo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomUser():
        return $default(
            _that.username,
            _that.email,
            _that.defects,
            _that.lessonsPassed,
            _that.lessonsCorrect,
            _that.currentLevel,
            _that.currentCombo);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String username,
            String email,
            Map<String, int> defects,
            Map<String, int> lessonsPassed,
            Map<String, int> lessonsCorrect,
            Map<String, int> currentLevel,
            Map<String, int> currentCombo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomUser() when $default != null:
        return $default(
            _that.username,
            _that.email,
            _that.defects,
            _that.lessonsPassed,
            _that.lessonsCorrect,
            _that.currentLevel,
            _that.currentCombo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomUser implements CustomUser {
  const _CustomUser(
      {required this.username,
      required this.email,
      final Map<String, int> defects = const <String, int>{},
      final Map<String, int> lessonsPassed = const <String, int>{},
      final Map<String, int> lessonsCorrect = const <String, int>{},
      final Map<String, int> currentLevel = const <String, int>{},
      final Map<String, int> currentCombo = const <String, int>{}})
      : _defects = defects,
        _lessonsPassed = lessonsPassed,
        _lessonsCorrect = lessonsCorrect,
        _currentLevel = currentLevel,
        _currentCombo = currentCombo;
  factory _CustomUser.fromJson(Map<String, dynamic> json) =>
      _$CustomUserFromJson(json);

  @override
  final String username;
  @override
  final String email;
  final Map<String, int> _defects;
  @override
  @JsonKey()
  Map<String, int> get defects {
    if (_defects is EqualUnmodifiableMapView) return _defects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_defects);
  }

  final Map<String, int> _lessonsPassed;
  @override
  @JsonKey()
  Map<String, int> get lessonsPassed {
    if (_lessonsPassed is EqualUnmodifiableMapView) return _lessonsPassed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lessonsPassed);
  }

  final Map<String, int> _lessonsCorrect;
  @override
  @JsonKey()
  Map<String, int> get lessonsCorrect {
    if (_lessonsCorrect is EqualUnmodifiableMapView) return _lessonsCorrect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lessonsCorrect);
  }

  final Map<String, int> _currentLevel;
  @override
  @JsonKey()
  Map<String, int> get currentLevel {
    if (_currentLevel is EqualUnmodifiableMapView) return _currentLevel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_currentLevel);
  }

  final Map<String, int> _currentCombo;
  @override
  @JsonKey()
  Map<String, int> get currentCombo {
    if (_currentCombo is EqualUnmodifiableMapView) return _currentCombo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_currentCombo);
  }

  /// Create a copy of CustomUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomUserCopyWith<_CustomUser> get copyWith =>
      __$CustomUserCopyWithImpl<_CustomUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomUser &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._defects, _defects) &&
            const DeepCollectionEquality()
                .equals(other._lessonsPassed, _lessonsPassed) &&
            const DeepCollectionEquality()
                .equals(other._lessonsCorrect, _lessonsCorrect) &&
            const DeepCollectionEquality()
                .equals(other._currentLevel, _currentLevel) &&
            const DeepCollectionEquality()
                .equals(other._currentCombo, _currentCombo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      email,
      const DeepCollectionEquality().hash(_defects),
      const DeepCollectionEquality().hash(_lessonsPassed),
      const DeepCollectionEquality().hash(_lessonsCorrect),
      const DeepCollectionEquality().hash(_currentLevel),
      const DeepCollectionEquality().hash(_currentCombo));

  @override
  String toString() {
    return 'CustomUser(username: $username, email: $email, defects: $defects, lessonsPassed: $lessonsPassed, lessonsCorrect: $lessonsCorrect, currentLevel: $currentLevel, currentCombo: $currentCombo)';
  }
}

/// @nodoc
abstract mixin class _$CustomUserCopyWith<$Res>
    implements $CustomUserCopyWith<$Res> {
  factory _$CustomUserCopyWith(
          _CustomUser value, $Res Function(_CustomUser) _then) =
      __$CustomUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String username,
      String email,
      Map<String, int> defects,
      Map<String, int> lessonsPassed,
      Map<String, int> lessonsCorrect,
      Map<String, int> currentLevel,
      Map<String, int> currentCombo});
}

/// @nodoc
class __$CustomUserCopyWithImpl<$Res> implements _$CustomUserCopyWith<$Res> {
  __$CustomUserCopyWithImpl(this._self, this._then);

  final _CustomUser _self;
  final $Res Function(_CustomUser) _then;

  /// Create a copy of CustomUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? defects = null,
    Object? lessonsPassed = null,
    Object? lessonsCorrect = null,
    Object? currentLevel = null,
    Object? currentCombo = null,
  }) {
    return _then(_CustomUser(
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      defects: null == defects
          ? _self._defects
          : defects // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lessonsPassed: null == lessonsPassed
          ? _self._lessonsPassed
          : lessonsPassed // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lessonsCorrect: null == lessonsCorrect
          ? _self._lessonsCorrect
          : lessonsCorrect // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      currentLevel: null == currentLevel
          ? _self._currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      currentCombo: null == currentCombo
          ? _self._currentCombo
          : currentCombo // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

// dart format on
