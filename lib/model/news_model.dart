import 'dart:convert';
import 'package:flutter/foundation.dart';

enum ReadState { All, Unread, Completed }

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

class News {
  News({
    @required this.newsId,
    @required this.title,
    @required this.link,
    @required this.keywords,
    @required this.creator,
    @required this.videoUrl,
    @required this.description,
    @required this.content,
    @required this.pubDate,
    @required this.imageUrl,
    @required this.sourceId,
    @required this.readState,
  });

  final String newsId;
  final String title;
  final String link;
  final List<String> keywords;
  final List<String> creator;
  final String videoUrl;
  final String description;
  final String content;
  final DateTime pubDate;
  final String imageUrl;
  final String sourceId;
  ReadState readState;

  News copyWith({
    String title,
    String link,
    List<String> keywords,
    List<String> creator,
    String videoUrl,
    String description,
    String content,
    DateTime pubDate,
    String imageUrl,
    String sourceId,
    ReadState readState,
  }) =>
      News(
        newsId: this.newsId,
        title: title ?? this.title,
        link: link ?? this.link,
        keywords: keywords ?? this.keywords,
        creator: creator ?? this.creator,
        videoUrl: videoUrl ?? this.videoUrl,
        description: description ?? this.description,
        content: content ?? this.content,
        pubDate: pubDate ?? this.pubDate,
        imageUrl: imageUrl ?? this.imageUrl,
        sourceId: sourceId ?? this.sourceId,
        readState: readState ?? this.readState,
      );

  factory News.fromJson(Map<String, dynamic> json) => News(
        title: json["title"],
        link: json["link"],
        keywords: List<String>.from(json["keywords"] ?? [""].map((x) => x)),
        creator: List<String>.from(json["creator"] ?? [""].map((x) => x)),
        videoUrl: json["video_url"],
        description: json["description"],
        content: json["content"],
        pubDate: DateTime.parse(json["pubDate"]),
        imageUrl: json["image_url"],
        sourceId: json["source_id"],
        readState: ReadState.Unread,
        newsId: base64.encode(utf8.encode(json["link"])),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "creator": List<dynamic>.from(creator.map((x) => x)),
        "video_url": videoUrl,
        "description": description,
        "content": content,
        "pubDate": pubDate?.toIso8601String(),
        "image_url": imageUrl,
        "source_id": sourceId,
      };

  @override
  String toString() {
    return 'News(title: $title, link: $link, keywords: $keywords, creator: $creator, videoUrl: $videoUrl, description: $description, content: $content, pubDate: $pubDate, imageUrl: $imageUrl, sourceId: $sourceId)';
  }
}
