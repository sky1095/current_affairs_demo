import 'package:current_affairs_demo/routes.dart';
import 'package:current_affairs_demo/widgets/news_image.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/news_model.dart';
import '../provider/news_provider.dart';

class NewsShowcase extends StatefulWidget {
  const NewsShowcase({Key key}) : super(key: key);

  @override
  _NewsShowcaseState createState() => _NewsShowcaseState();
}

class _NewsShowcaseState extends State<NewsShowcase> {
  Future<List<News>> parseNews;

  @override
  void initState() {
    super.initState();

    parseNews = Provider.of<NewsProvider>(context, listen: false).parseNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Current Affairs",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton(
              color: Colors.white,
              elevation: 20,
              initialValue: newsProvider.selectedReadState,
              icon: Icon(
                Icons.settings,
                color: Colors.teal.shade300,
              ),
              onSelected: (value) {
                newsProvider.chooseReadState = value;
              },
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
              itemBuilder: (context) => [
                    for (ReadState state in ReadState.values)
                      PopupMenuItem(
                        child: Text(state.toString().split(".").last),
                        value: state,
                      ),
                  ])
        ],
      ),
      body: FutureBuilder<List<News>>(
        future: parseNews,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Uh-Oh, No news for now!"),
            );
          } else if (snapshot.hasData) {
            final allNews = newsProvider.currentNews;
            return ListView.separated(
              itemCount: allNews.length,
              itemBuilder: (context, index) {
                return buildNewsCard(allNews[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 8,
                  endIndent: 8,
                  color: Colors.grey.shade700,
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildNewsCard(News news) {
    final size = MediaQuery.of(context).size;
    final imageBoxHeight = (size.height / 5) * 0.4;
    final newsProvider = Provider.of<NewsProvider>(context);
    return InkWell(
      onTap: () {
        newsProvider.selectedNews = news;
        Navigator.pushNamed(context, RouteName.newsDetails, arguments: [news]);
      },
      child: Container(
        height: size.height / 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
              child: Text(DateFormat("MMMM dd, yyyy").format(news.pubDate)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        news.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: newsProvider.isRead(news)
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: NewsImage(
                    height: imageBoxHeight,
                    news: news,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
