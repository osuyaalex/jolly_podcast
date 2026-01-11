import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import '../backend/models/trending_model.dart';

class EpisodesService {
  static Future<TrendingResponseModel?> fetchTrendingEpisodes({
    required int page,
    required int perPage,
  }) async {
    try {
      final token = await ApiService.getToken();

      if (token == null) {
        throw 'Authentication required';
      }

      String url = "${ApiService.baseUrl}/api/episodes/trending?page=$page&per_page=$perPage";

      final response = await http.get(
        Uri.parse(url),
        headers: ApiService.getHeaders(token: token),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return TrendingResponseModel.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        throw 'Authentication failed. Please login again.';
      } else {
        final jsonResponse = jsonDecode(response.body);
        throw jsonResponse['message'] ?? 'Failed to load episodes';
      }
    } catch (error) {
      throw ApiService.parseErrorMessage(error.toString());
    }
  }
}
