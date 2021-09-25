import 'dart:collection';

import 'package:current_affairs_demo/model/news_model.dart';
import 'package:current_affairs_demo/services/api_response.dart';
import 'package:current_affairs_demo/services/web_services.dart';
import 'package:flutter/foundation.dart';

class NewsProvider extends ChangeNotifier {
  HashMap<String, News> _allNews = HashMap();

  List<News> get currentNews {
    if (_selectedReadState == ReadState.All) {
      return _allNews.values.toList();
    } else {
      return _allNews.values
          .where((news) => news.readState == _selectedReadState)
          .toList();
    }
  }

  News _selectedNews;
  News get selectedNews => _selectedNews;
  set selectedNews(News news) {
    _selectedNews = _allNews[news.newsId];
    notifyListeners();
  }

  ReadState _selectedReadState = ReadState.All;
  ReadState get selectedReadState => _selectedReadState;

  set chooseReadState(ReadState state) {
    _selectedReadState = state;
    notifyListeners();
  }

  bool isRead(News news) {
    if (_allNews[news.newsId].readState == ReadState.Unread) {
      return false;
    } else {
      return true;
    }
  }

  void updateNews(News news) {
    _allNews[news.newsId] = news;
    _selectedNews = _allNews[news.newsId];
    notifyListeners();
  }

  Future<List<News>> parseNews() async {
    try {
      ApiResponse apiResponse = await Api.fetchCurrentNews();
      if (apiResponse.status == ApiStatus.Success) {
        List<News> allNews = newsFromJson(apiResponse.results);
        for (News news in allNews) {
          _allNews[news.newsId] = news;
        }
        return _allNews.values.toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error parsing news because of ${e.toString()}");
      throw e;
    }
  }
}
