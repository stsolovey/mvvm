import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://d5dt020imppvuh0v7uks.apigw.yandexcloud.net/';
  static const _imageUrl = '';
  static const _apiKey = '';

  Uri makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host' + path);
    return uri;
  }

  Future<String> register(
      {required String login,
      required String password,
      required String email}) async {
    String path = '/register';
    final url = Uri.parse('$_host' + path);

    final parameters = <String, dynamic>{
      'login': login,
      'password': password,
      'email': email
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['token'] as String;
    return token;
  }

  Future<String> login(
      {required String login, required String password}) async {
    String path = '/login';
    final url = Uri.parse('$_host' + path);

    final parameters = <String, dynamic>{'login': login, 'password': password};
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['token'] as String;
    return token;
  }
}
