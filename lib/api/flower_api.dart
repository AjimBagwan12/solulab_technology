import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flower_api.g.dart';

@RestApi(baseUrl: "https://mocki.io/v1/")
abstract class FlowerApi {
  factory FlowerApi(Dio dio, {String baseUrl}) = _FlowerApi;

  @GET("1d0d7935-3c14-41f0-aecb-3184090a5127")
  Future<List<Flower>> getFlowers(dio);
}

@JsonSerializable()
class Flower {
  final String name;
  final String description;
  final String imageUrl;

  Flower({required this.name, required this.description, required this.imageUrl});

  factory Flower.fromJson(Map<String, dynamic> json) => _$FlowerFromJson(json);
  Map<String, dynamic> toJson() => _$FlowerToJson(this);
}

class _FlowerApi implements FlowerApi{
  _FlowerApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://mocki.io/v1/';

  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Flower>> getFlowers(dio) async {
    final response = await _dio.get<List<dynamic>>('1d0d7935-3c14-41f0-aecb-3184090a5127');
    return response.data!.map((item) => Flower.fromJson(item as Map<String, dynamic>)).toList();
  }
}