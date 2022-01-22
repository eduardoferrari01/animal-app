import 'dart:io';
import 'package:animal_app/http/exception/not_found_exception.dart';
import 'package:animal_app/model/animal.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../webclient.dart';

//const String baseUrl = 'https://information-api.herokuapp.com/api/snake/information';
const String baseUrl = 'http://192.168.0.108:8080/api/snake/information/find';

class AnimalWebClient {
  Future<Animal> findAnimalByLabel(String label) async {

    Response response = await client.get(Uri.parse(baseUrl+"/$label"));

    if (response.statusCode == 200) {
      return Animal.fromJson(jsonDecode(response.body));
    }

    if (response.statusCode == 404) {
      throw NotFoundException(_getMessage(response.statusCode));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode]!;
    }

    return 'Ocorreu um erro desconhecido';
  }

  static final Map<int, String> _statusCodeResponses = {
    404: 'Animal não encontrado',
    400: 'Ocorreu um erro ao buscar animal',
    502: 'Falha na comunicação entre dois ou mais servidores',
  };
}
