import 'package:current_affairs_demo/views/news_details.dart';
import 'package:current_affairs_demo/views/news_showcase.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.newsDetails:
        return MaterialPageRoute(builder: (context) {
          return NewsDetails();
        });

      case RouteName.initialRoute:
      default:
        return MaterialPageRoute(builder: (context) {
          return NewsShowcase();
        });
    }
  }
}

class RouteName {
  static const String initialRoute = "/";
  static const String newsDetails = "/newsDetails";
}
