import "dart:async";

import 'package:chopper/chopper.dart';

part 'news_service.chopper.dart';

@ChopperApi()
abstract class NewsService extends ChopperService {
  static NewsService create([ChopperClient client]) => _$NewsService(client);

  @Get(path: '/topstories.json')
  Future<Response> getNewsList();

  @Get(path: '/item/{newsId}.json')
  Future<Response<Map>> getNews(@Path('newsId') int newsId);
}