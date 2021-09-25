import 'package:current_affairs_demo/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/news_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteGenerator routeGenerator = RouteGenerator();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()),
      ],
      child: MaterialApp(
        title: 'Current Affairs Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: NewsShowcase(),
        initialRoute: RouteName.initialRoute,
        onGenerateRoute: routeGenerator.generateRoute,
      ),
    );
  }
}
