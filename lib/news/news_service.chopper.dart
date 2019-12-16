// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$NewsService extends NewsService {
  _$NewsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsService;

  @override
  Future<Response> getNewsList() {
    final $url = '/topstories.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map>> getNews(int newsId) {
    final $url = '/item/$newsId.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map, Map>($request);
  }
}
