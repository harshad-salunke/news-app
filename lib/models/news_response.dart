import 'package:newsapp/models/article_model.dart';

class NewsResponseModel {
  String status;
  int totalResults;
  List<Article> articles;

  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      status: json['status']??'',
      totalResults: json['totalResults']??0,
      articles: List<Article>.from(
          json['articles'].map((article) => Article.fromJson(article))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}