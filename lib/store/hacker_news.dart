import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import 'package:fl_cau/news/news.dart';
import 'package:fl_cau/news/news_list.dart';
import 'package:fl_cau/news/news_endpoints.dart';

part 'hacker_news.g.dart';

const _limits = 7;

class HackerNews = HackerNewsBase with _$HackerNews;

abstract class HackerNewsBase with Store {
  @observable
  List newsList = [];

  @observable
  List<News> news = [];

  @observable
  int newsLimit = _limits;

  @action
  increaseNewsLimit() {
    newsLimit = newsLimit + _limits;
    getNewsList();
  }

  @action
  getNewsList() {
    fetchNewsList().then((newsListObject) {
      newsList = newsListObject.topStoryIndexes;
      getNews(newsList, newsLimit).then((listOfArticles) {
        List<News> listOfNews = news;
        listOfArticles.forEach((newsArticle) {
          listOfNews.add(newsArticle);
        });
        news = listOfNews;
      });
    });
  }
}

Future<NewsList> fetchNewsList() async {
  final response = await http.get(NewsEndpoints.newsListUrl);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    print('News IDs List => ${parsedJson.toString()}');
    return NewsList.fromJson(parsedJson);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<News>> getNews(List newsIdList, int indexRange) async {
  List<News> listOfNews = [];
  // for (int index = 0; index < newsIdList.length; index++) {
  // Fetching news only per the limits for now
  for (int index = (indexRange - _limits); index < indexRange; index++) {
    News news = await fetchNews(int.parse(newsIdList[index].toString()));
    listOfNews.add(news);
  }
  return listOfNews;
}

Future<News> fetchNews(int newsId) async {
  String url = NewsEndpoints.newsUrl(newsId);
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    print('News ID DETAILS => ${parsedJson.toString()}');
    return News.fromJson(parsedJson);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post for Id $newsId');
  }
}
