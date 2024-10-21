class Ip {
  String? _ip; // Айпи, если пользователь решит поменять его
  String defaulIp = ''; // Поле для айпи сервера 
  
  void setIp(String ip) {
    _ip = ip;
  }

  void resetIp() {
    _ip = null;
  }

  String get getIp => _ip ?? defaulIp;
}