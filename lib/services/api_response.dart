import 'dart:convert';
import 'package:meta/meta.dart';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

enum ApiStatus { Success, Error }

class ApiResponse {
  final ApiStatus status;
  final int totalResults;
  final String results;
  final int nextPage;

  ApiResponse({
    @required this.status,
    @required this.totalResults,
    @required this.results,
    @required this.nextPage,
  });

  ApiResponse copyWith({
    ApiStatus status,
    int totalResults,
    String results,
    int nextPage,
  }) =>
      ApiResponse(
        status: status ?? this.status,
        totalResults: totalResults ?? this.totalResults,
        results: results ?? this.results,
        nextPage: nextPage ?? this.nextPage,
      );

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status:
            json["status"] == "success" ? ApiStatus.Success : ApiStatus.Error,
        totalResults: json["totalResults"],
        results: jsonEncode(json["results"]),
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "results": results,
        "nextPage": nextPage,
      };
}
