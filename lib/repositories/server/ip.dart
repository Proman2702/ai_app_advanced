class Ip {
  static String? _ip; // Айпи, если пользователь решит поменять его
  String defaultIp = 'http://0.tcp.eu.ngrok.io:14650/upload'; // Поле для айпи сервера

  void setIp(String ip) {
    _ip = ip;
  }

  void resetIp() {
    _ip = null;
  }

  String get getIp => _ip ?? defaultIp;
}
