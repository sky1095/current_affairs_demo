import 'package:current_affairs_demo/services/api_response.dart';
import 'package:http/http.dart' as http;

class WebServices {
  final String _baseUrl = "https://newsdata.io/api/1/news";

  Future<String> performGet(String query) async {
    final httpClient = http.Client();
    final String queriedUrl = "$_baseUrl?$query";

    final Uri uri = Uri.parse(queriedUrl);
    final header = {'X-ACCESS-KEY': 'pub_14540bdfc0f25ed58e0e2dbac52f5744dc17'};

    try {
      http.Response response = await httpClient.get(uri, headers: header);
      return response.body;
    } catch (e) {
      throw e;
    }
  }
}

class Api {
  static final _webServices = WebServices();

  static Future<ApiResponse> fetchCurrentNews() async {
    final Map params = {'country': 'in'};

    String query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    try {
      String rawResponse = await _webServices.performGet(query);

      ApiResponse apiResponse = apiResponseFromJson(rawResponse);
      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }
}
