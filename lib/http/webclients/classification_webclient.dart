import 'dart:io';
import 'package:animal_app/http/exception/not_found_exception.dart';
import 'package:http/http.dart' as http;

import 'package:animal_app/model/animal.dart';
import 'dart:convert';
import 'dart:developer';

//const String baseUrl = 'https://information-api.herokuapp.com/api/snake/information';
const String baseUrl = 'http://192.168.0.109:8080/api/animal/information';
const timeout = 5;

class IdentifiesWebClient {

  Future<Animal> identifyAnimal(File file) async {
    http.MultipartRequest request = await _requestMultipartBuild(file);

    _requestLog(request);

    http.StreamedResponse response = await request.send().timeout(const Duration(seconds: timeout));
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    _responseLog(response, responseString);

    if (response.statusCode == 200) {
        return Animal.fromJson(jsonDecode(responseString));
    }

    if (response.statusCode == 404) {
      throw NotFoundException(_getMessage(response.statusCode));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  Future<http.MultipartRequest> _requestMultipartBuild(File file) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    return request;
  }

  void _responseLog(http.StreamedResponse response, String responseString) {
    log('Response');
    log('status code: ${response.statusCode}');
    log('headers: ${response.headers}');
    log('body: {$responseString}');
  }

  void _requestLog(http.MultipartRequest request) {
    log('Request');
    log('url: ${request.url}');
    log('headers: ${request.headers}');
    log('body: ${request.files.join(',')}');
  }

  String _getMessage(int statusCode) {

    if(_statusCodeResponses.containsKey(statusCode)){
        return _statusCodeResponses[statusCode]!;
    }

    return 'Ocorreu um erro desconhecido';
  }

  static final Map<int, String> _statusCodeResponses ={
    404: 'unidentified animal',
    400: 'Ocorreu um erro ao identificar',
    502: 'Falha na comunicação entre dois ou mais servidores',

  };
}
