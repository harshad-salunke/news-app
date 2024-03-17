import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:newsapp/models/article_model.dart';

import '../../Models/UserModle.dart';

import 'package:intl/intl.dart';

import '../providers/firbase_auth_handler.dart';

class FirebaseDatabaseDAO {


   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   StreamController<UserModel> _userController = StreamController<UserModel>.broadcast();
   Stream<UserModel> get userStream => _userController.stream;

   StreamController<List<Article>> _loveArticleController = StreamController<List<Article>>.broadcast();
   Stream<List<Article>> get loveArticleStream => _loveArticleController.stream;

   StreamController<List<Article>> _readingArticleController = StreamController<List<Article>>.broadcast();
   Stream<List<Article>> get readingStream => _readingArticleController.stream;

   void  fetchUserDetails() {
     String current_user_uid=firebaseAuth.currentUser!.uid;
     databaseReference.child('Users').child(current_user_uid).onValue.listen((event) {
       if (event.snapshot.value != null) {
         Map values = event.snapshot.value as Map;
         UserModel userModel=UserModel.fromJson(values);
         _userController.add(userModel);
       }
     }).onError((error){
       print(error.toString());
     });

   }


   void  fetchLovedArticleDetails() {
     String current_user_uid=firebaseAuth.currentUser!.uid;
     databaseReference.child('Loved').child(current_user_uid).onValue.listen((event) {
       if (event.snapshot.value != null) {
         Map<dynamic, dynamic> values = event.snapshot.value as Map;
         print('Loved ${values}');
         List<Article> articleList = [];

         values.forEach((key, value) {
           articleList.add(Article.fromJson(Map<String, dynamic>.from(value)));
         });
         _loveArticleController.add(articleList);
       }else{
         _loveArticleController.add([]);
       }
     }).onError((error){
       print(error.toString());
     });


   }

   void  fetchReadingArticleDetails() {
     String current_user_uid=firebaseAuth.currentUser!.uid;
     databaseReference.child('Reading').child(current_user_uid).onValue.listen((event) {
       if (event.snapshot.value != null) {
         Map<dynamic, dynamic> values = event.snapshot.value as Map;
         print('Loved ${values}');
         List<Article> articleList = [];

         values.forEach((key, value) {
           articleList.add(Article.fromJson(Map<String, dynamic>.from(value)));
         });
         _readingArticleController.add(articleList);
       }else{
         _readingArticleController.add([]);
       }
     }).onError((error){
       print(error.toString());
     });


   }

   Future<void> clearRecentReading(UserModel userModel)async{
     String path = 'Reading/${userModel.uid}';
     await databaseReference.child(path).remove();

   }


   Future<UserModel> saveUserDetails(UserModel userModel) async {
     userModel.uid=FirebaseAuthHandler.firebaseAuth.currentUser!.uid;
     Map<String, dynamic> data = userModel.toJson();

     String path = 'Users/${userModel.uid}';

     await databaseReference.child(path).set(data);
     return userModel;
   }

   Future<Article> saveLovedArticle(Article article,UserModel userModel) async {

     Map<String, dynamic> data = article.toJson();

     String path = 'Loved/${userModel.uid}';
     await databaseReference.child(path).push().set(data);

     return article;
   }

   Future<Article> saveReadingArticle(Article article,UserModel userModel) async {
     Map<String, dynamic> data = article.toJson();

     String path = 'Reading/${userModel.uid}';
     await databaseReference.child(path).push().set(data);

     return article;
   }
   Future<UserModel> updateUserDetails(UserModel userModel) async {
     Map<String, dynamic> data = userModel.toJson();

     String path = 'Users/${userModel.uid}';

     await databaseReference.child(path).update(data);
     return userModel;
   }
}
