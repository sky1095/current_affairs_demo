import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/news_model.dart';
import '../provider/news_provider.dart';
import '../widgets/news_image.dart';

class NewsDetails extends StatefulWidget {
  // final News news;
  const NewsDetails({
    Key key,
  }) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    double actualHeight = size.height - padding.vertical;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Current Affairs",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: actualHeight * 0.05),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsProvider.selectedNews.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          NewsImage(
            height: actualHeight * 0.4,
            news: newsProvider.selectedNews,
          ),
          ListTile(
            trailing: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: IconButton(
                onPressed: () {
                  News updatedNews = newsProvider.selectedNews.copyWith(
                      readState: newsProvider.isRead(newsProvider.selectedNews)
                          ? ReadState.Unread
                          : ReadState.Completed);
                  newsProvider.updateNews(updatedNews);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: newsProvider.isRead(updatedNews)
                          ? Colors.teal.shade300
                          : Colors.grey.shade400,
                      content: Text(newsProvider.isRead(updatedNews)
                          ? "Marked as Read"
                          : "Marked as Unread"),
                    ),
                  );
                },
                icon: Icon(
                  Icons.checklist_sharp,
                  color: newsProvider.isRead(newsProvider.selectedNews)
                      ? Colors.teal.shade300
                      : Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: actualHeight * 0.02),
          buildDescription(newsProvider.selectedNews.description)
        ],
      ),
    );
  }

  Widget buildDescription(String description) {
    List<String> descriptionAsPoints = description.split(".");
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: descriptionAsPoints.length,
      itemBuilder: (context, index) {
        if (descriptionAsPoints[index].isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "\u2022 ${descriptionAsPoints[index]}",
              style: TextStyle(color: Colors.black),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
