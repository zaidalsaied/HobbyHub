import 'package:http/http.dart' as http;

class UploadImageService {
  static Future<String> uploadImage(String fileName, String path) async {
    try {
      print("usrenme:$fileName");
      print("path:$path");

      var request = http.MultipartRequest(
          'POST', Uri.parse('https://kaizokuni.com/hobbyhub/uploadeImage.php'));
      request.fields.addAll({'name': fileName});
      request.files.add(await http.MultipartFile.fromPath('file', path));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("uploaded");
        return "https://kaizokuni.com/hobbyhub/$fileName";
      } else {
        print("not uploaded");
        return null;
      }
    } catch (e) {
      print("not uploaded");
      print(e);
      return null;
    }
  }
}
