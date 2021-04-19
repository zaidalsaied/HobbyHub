import 'package:hobby_hub_ui/network/res/endpoints.dart';
import 'package:http/http.dart' as http;

class HobbyApi {
  Future getAllHobbies() async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${Endpoints.host}${Endpoints.hobbyEndpoint}${Endpoints.getAllHobbies}'));
      request.headers.addAll(Endpoints.headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
