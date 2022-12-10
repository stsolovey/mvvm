import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://d5dt020imppvuh0v7uks.apigw.yandexcloud.net/';
  static const _imageUrl = '';
  static const _apiKey = '';

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> register(
      {required String login,
      required String password,
      required String email}) async {
    String path = 'register';

    final parameters = <String, dynamic>{
      'login': login,
      'password': password,
      'email': email
    };

    final url = _makeUri(path, parameters);
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['token'] as String;
    return token;
  }

  Future<Map<String, dynamic>> login(
      {required String login, required String password}) async {
    String path = 'login';

    final parameters = <String, dynamic>{'login': login, 'password': password};
    final uri = _makeUri(path, parameters);

    final request = await _client.postUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    //final token = json['token'] as String;
    //return token;
    return json;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
