import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

// Апи сервера на фласке, где хранится модель

class UploadAudio {
  Future<int> uploadAudio(String filename, String url) async {
    try {
      // Задается настройка запроса (айпи сервера, максимальное ожидание)

      final BaseOptions options = BaseOptions(
        baseUrl: url,
        validateStatus: (status) => true,
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      );

      // импорт библиотеки с параметрами
      final dio = Dio(options);

      final a = await File(filename).length();
      log('FILENAME LENGTH $a');

      // Сборка аудиофалйа и его названия для отправки на сервер
      final formData = FormData.fromMap(
          {"audio": MultipartFile.fromBytes(File(filename).readAsBytesSync(), filename: filename.split("/").last)});
      log("<upload> после формирования даты");

      // Пост-запрос на сервер с отправкой файла
      var response = await dio.post(
        url,
        data: formData,
      );

      // Обработчик ошибок
      if (response.statusCode == 200) {
        log('<upload> Аудиофайл успешно загружен');
        log("<upload> ${response.data["prediction"][0]}");
        return response.data["prediction"][0];
      } else {
        log('<upload> Ошибка при загрузке: ${response.statusCode} ${response.statusMessage}');
        return 400;
      }

      // Что-то пошло не так в основном функционале
    } catch (e) {
      log('<upload> $e');
      return 400;
    }
  }
}
