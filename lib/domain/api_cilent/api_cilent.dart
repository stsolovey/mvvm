import 'dart:convert';
import 'dart:io';

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
    final url = _makeUri(path);

    final parameters = <String, dynamic>{
      'login': login,
      'password': password,
      'email': email
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['token'] as String;
    return token;
  }

  Future<String> login({
      required String login, 
      required String password
      }) async {
    print('started login');
    String path = 'login';
    final url = _makeUri(path);
    print('this is uri: $url');
    final parameters = <String, dynamic>{'login': login, 'password': password};
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = (await response.jsonDecode()) as Map<String, dynamic>;
    print(json);
    final token = json['token'] as String;
    return token;
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