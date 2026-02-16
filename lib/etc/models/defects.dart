enum Defects {
  zaikanie(code: 0, title: "Заикание"),
  kartavost(code: 1, title: "Картавость"),
  fricativnoeG(code: 2, title: "Фрикативное Г");

  final int code;
  final String title;
  const Defects({required this.code, required this.title});
}
