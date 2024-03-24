import 'package:flutter/cupertino.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:newsapp/services/api_request/apiRequestAsistance.dart';

class ApiService {
  final String _newsUrl = 'https://newsapi.org/v2';
  final String _baseUrl='https://candidate-test-data-moengage.s3.amazonaws.com/Android/news-api-feed/staticResponse.json';
  final String _apiKey = '040c2cd9faae444484299428385d17ba';


  Future<NewsResponseModel?> getHomePageNews() async {
    String url = _baseUrl;
    var response = await ApiRequestAsistance.getRequest(url);
    NewsResponseModel newsResponse = NewsResponseModel.fromJson(response);
    print(newsResponse.totalResults);
    print(newsResponse.articles.length);
    if (response != 'failed') {
      return newsResponse;
    } else {
      return null;
    }
  }


  Future<NewsResponseModel?> getHomePageTagNews(String category) async {
    String url =
        "${_newsUrl}/top-headlines?country=in&category=${category}&apiKey=${_apiKey}";
    var response = await ApiRequestAsistance.getRequest(url);
    NewsResponseModel newsResponse = NewsResponseModel.fromJson(response);
    print(newsResponse.totalResults);
    print(newsResponse.articles.length);

    if (response != 'failed') {
      return newsResponse;
    }
    return null;
  }


  Future<NewsResponseModel?> getNewsByCategory(String category) async {
    String url =
        "${_newsUrl}/top-headlines?category=${category}&apiKey=${_apiKey}";
    var response = await ApiRequestAsistance.getRequest(url);
    NewsResponseModel newsResponse = NewsResponseModel.fromJson(response);
    print(newsResponse.totalResults);
    print(newsResponse.articles.length);

    if (response != 'failed') {
      return newsResponse;
    }
    return null;
  }


  Future<NewsResponseModel?> getNewsByCountry(String country) async {
    String url =
        "${_newsUrl}/top-headlines?country=${country}&apiKey=${_apiKey}";
    var response = await ApiRequestAsistance.getRequest(url);
    NewsResponseModel newsResponse = NewsResponseModel.fromJson(response);
    print(newsResponse.totalResults);
    print(newsResponse.articles.length);

    if (response != 'failed') {
      return newsResponse;
    }
    return null;
  }


  Future<NewsResponseModel?> getNewsByCountryAndCategory(String category,String country) async {
    String url =
        "${_newsUrl}/top-headlines?country=${country}&category=${category}&apiKey=${_apiKey}";
    var response = await ApiRequestAsistance.getRequest(url);
    NewsResponseModel newsResponse = NewsResponseModel.fromJson(response);
    print(newsResponse.totalResults);
    print(newsResponse.articles.length);

    if (response != 'failed') {
      return newsResponse;
    }
    return null;
  }


}
