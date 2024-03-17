import 'package:flutter/cupertino.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/news_response.dart';
import 'package:newsapp/services/api_request/apiServiceMethods.dart';
import 'package:newsapp/services/firebase_service/firebase_database_dao.dart';

import '../../Models/UserModle.dart';

class NewsProvider extends ChangeNotifier{

 final ApiService _apiService=ApiService();
  final FirebaseDatabaseDAO _firebaseDatabaseDAO=FirebaseDatabaseDAO();

  List<Article> articleList=[];
  List<Article> lovedArticleList=[];
 List<Article> readingArticleList=[];

 List<Article> filterList=[];


  bool isNewsLoading=true;
  bool isFilterNewsLoading=true;
  bool isLovedArticleLoading=true;
  bool isreadingArticleLoading=true;

 late Article selectedArtical;
 late UserModel userData = UserModel(
     phone_number: '',
     name: '',
     uid: '',
     gender: '',
     email: '',
     password: '');


 void fetchUserDetails() {
   _firebaseDatabaseDAO.userStream.listen((user) {
     userData = user;
     notifyListeners();
   });
   print('user data is ${userData.toJson()}');
   _firebaseDatabaseDAO.fetchUserDetails();
 }

 void fetchLovedArticle() {
   _firebaseDatabaseDAO.loveArticleStream.listen((articles) {
     lovedArticleList = articles;
     isLovedArticleLoading = false;
     notifyListeners();
   });
   lovedArticleList.forEach((element) {
     print('loved');
     print(element.title);
   });
   _firebaseDatabaseDAO.fetchLovedArticleDetails();
 }

 void fetchReadingArticle() {
   _firebaseDatabaseDAO.readingStream.listen((articles) {
     readingArticleList = articles;
     isreadingArticleLoading = false;
     notifyListeners();
   });

   _firebaseDatabaseDAO.fetchReadingArticleDetails();
 }

 Future<void> fetchHomeNews()async{
    articleList.clear();
    NewsResponseModel? newsResponse=   await _apiService.getHomePageNews();
    if(newsResponse!=null){
      articleList=newsResponse.articles;
    }
    isNewsLoading=false;

    notifyListeners();
  }

  Future<void> fetchTagBasedNews(String category)async{
    articleList.clear();
    NewsResponseModel? newsResponse=   await _apiService.getHomePageTagNews(category);
    if(newsResponse!=null){
      articleList=newsResponse.articles;
    }
    isNewsLoading=false;

    notifyListeners();
  }

 Future<void> fetchCountryBasedNews(String country)async{
   filterList.clear();
   NewsResponseModel? newsResponse=   await _apiService.getNewsByCountry(country);
   if(newsResponse!=null){
     filterList=newsResponse.articles;
   }
   isFilterNewsLoading=false;

   notifyListeners();
 }


 Future<void> fetchCategoryBasedNews(String category)async{
   filterList.clear();
   NewsResponseModel? newsResponse=   await _apiService.getNewsByCategory(category);
   if(newsResponse!=null){
     filterList=newsResponse.articles;
   }
   isFilterNewsLoading=false;

   notifyListeners();
 }



 Future<void> fetchCountryAndCategoryNews(String category,String country)async{
   filterList.clear();
   NewsResponseModel? newsResponse=   await _apiService.getNewsByCountryAndCategory(category,country);
   if(newsResponse!=null){
     filterList=newsResponse.articles;
   }
   isFilterNewsLoading=false;

   notifyListeners();
 }

 Future<void> clearRecentReading()async{
   await _firebaseDatabaseDAO.clearRecentReading(userData);

 }

 Future<void> updateUserDetails(UserModel userModel) async {
   userData = await _firebaseDatabaseDAO.updateUserDetails(userModel);
   notifyListeners();
 }

 //save data to database
 Future<void> saveUserDetails(UserModel userModel) async {
   userData = await _firebaseDatabaseDAO.saveUserDetails(userModel);
   notifyListeners();
 }

 Future<void> savedLovedArticle(Article article) async {
    await _firebaseDatabaseDAO.saveLovedArticle(article,userData);
   notifyListeners();
 }

 Future<void> savedRecentReadArticle(Article article) async {
   await _firebaseDatabaseDAO.saveReadingArticle(article,userData);
   notifyListeners();
 }

 void setEmptyArticleList(){
    isNewsLoading=true;
    articleList=[];
    notifyListeners();
  }

 void setEmptyFilterArticleList(){
   isFilterNewsLoading=true;
   filterList=[];
   notifyListeners();
 }

  void setSelectedArticle(Article article){
    selectedArtical=article;

    savedRecentReadArticle(article);
    notifyListeners();
  }


}