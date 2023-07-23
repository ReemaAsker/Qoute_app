import '../services/Networking.dart';

class Qoute {
  late String content;
  late String author;
  late String desc;
  Future<List<dynamic>> getRandomQoute() async {
    List<dynamic> qoutData =
        await NetworkHelper('https://api.quotable.io/quotes/random').getData();

    content = qoutData[0]['content'];
    author = qoutData[0]['author'];
    desc = qoutData[0]['tags'][0];

    return qoutData;
  }
}
