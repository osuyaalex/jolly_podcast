import 'package:flutter/foundation.dart';
import '../services/episodes_service.dart';
import 'models/trending_model.dart';

class EpisodesProvider with ChangeNotifier {
  List<EpisodeData> _trendingEpisodes = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;

  List<EpisodeData> get trendingEpisodes => _trendingEpisodes;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get error => _error;
  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;

  // Kept for backward compatibility with UI
  String? get mainError => _error;

  Future<void> fetchTrendingEpisodes({bool loadMore = false}) async {
    if (loadMore) {
      if (!_hasMore || _isLoadingMore) return;
      _isLoadingMore = true;
      _currentPage++;
    } else {
      _isLoading = true;
      _currentPage = 1;
      _trendingEpisodes = [];
      _hasMore = true;
    }

    _error = null;
    notifyListeners();

    try {
      final trendingModel = await EpisodesService.fetchTrendingEpisodes(
        page: _currentPage,
        perPage: 10,
      );

      if (trendingModel?.data?.data?.data != null) {
        if (loadMore) {
          _trendingEpisodes.addAll(trendingModel!.data!.data!.data!);
        } else {
          _trendingEpisodes = trendingModel!.data!.data!.data!;
        }

        // Check if there are more pages
        _hasMore = trendingModel.data!.data!.nextPageUrl != null;
      }

      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    } catch (error) {
      _error = error.toString();
      _isLoading = false;
      _isLoadingMore = false;

      // Revert page if loading more failed
      if (loadMore && _currentPage > 1) {
        _currentPage--;
      }

      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
