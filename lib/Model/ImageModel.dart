import '../services/Networking.dart';

class RandomImage {
  late String imgDesc;
  RandomImage({required this.imgDesc});

  Future<String> getRandomImag() async {
    String url = "";
    Map<String, dynamic> randomImageUrl = await NetworkHelper(
            'https://random.imagecdn.app/v1/image?category=$imgDesc&format=json')
        .getDataforRandomImag();

    url = randomImageUrl["url"];
    return url;
  }
}
