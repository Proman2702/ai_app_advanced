import 'dart:developer';

import 'package:dio/dio.dart';

class UploadAudio {
  Future<int> uploadAudio(String filename, String url) async {
    try {
      final BaseOptions options = BaseOptions(
        baseUrl: url,
        validateStatus: (status) => true,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        // responseType: ResponseType.plain,
      );
      final dio = Dio(options);
      final formData = FormData.fromMap({"audio": await MultipartFile.fromFile(filename)});
      log("<upload> после формирование даты");

      var response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        log('Аудиофайл успешно загружен');
        log("${response.data["prediction"][0]}");
        return response.data["prediction"][0];
      } else {
        log('Ошибка при загрузке: ${response.statusCode}');
        return 400;
      }
    } catch (e) {
      log('$e');
      return 400;
    }
  }
}
