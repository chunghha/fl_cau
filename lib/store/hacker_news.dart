import 'package:chopper/chopper.dart';
import 'package:mobx/mobx.dart';

import 'package:fl_cau/news/news.dart';
import 'package:fl_cau/news/news_list.dart';
import 'package:fl_cau/news/news_endpoints.dart';
import 'package:fl_cau/news/news_service.dart';

part 'hacker_news.g.dart';

final newsService = NewsService.create(ChopperClient(
  baseUrl: NewsEndpoints.newsBaseUrl,
  services: [NewsService.create()],
  converter: JsonConverter(),
));

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
  final response = await newsService.getNewsList();

  if (response.statusCode == 200) {
    print('News IDs List => ${response.body}');
    return NewsList.fromJson(response.body);
  } else {
    throw Exception('Failed to load a list of news: ${response.error}');
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
  final response = await newsService.getNews(newsId);

  if (response.statusCode == 200) {
    print('News ID DETAILS => ${response.body}');
    return News.fromJson(response.body);
  } else {
    throw Exception('Failed to load news of $newsId: ${response.error}');
  }
}
