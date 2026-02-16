import 'dart:math' as math;
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/server/network_guard.dart';
import 'package:dio/dio.dart';

class Network {
  final Dio dio;

  Network(this.dio);

  final BaseOptions _options = BaseOptions(
    baseUrl: "",
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 40),
    sendTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
  );

  String _randomizeName(int length) {
    const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final math.Random rnd = math.Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Future<Result> uploadAudio(String filename, String url) async {
    dio.options = _options;

    return NetworkGuard.networkGuard(() async {
      final formData = FormData.fromMap({
        "audio": await MultipartFile.fromFile(filename, filename: "${_randomizeName(16)}.wav"),
      });

      final r = await dio.post<Map<String, dynamic>>(url, data: formData);

      final pred = (r.data?["prediction"] as List?)?.first;
      if (pred == null) throw const FormatException("prediction missing");

      return pred.toInt();
    });
  }
}
