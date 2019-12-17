import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:supercharged/supercharged.dart';

import 'package:fl_cau/news/news.dart';
import 'package:fl_cau/store/hacker_news.dart';

class NewsPage extends StatefulWidget {
  @override
  NewsState createState() {
    return new NewsState();
  }
}

class NewsState extends State<NewsPage> {
  // TOOD: see later if this can be from Provider
  final hackerNews = HackerNews();
  
  final snackBar = SnackBar(
    content: Text('News List will be update in sometime..',
        style: GoogleFonts.girassol(fontSize: 18.0)),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change!
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    hackerNews.getNewsList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: '#233555'.toColor(),
          title: Text(
            'Hacker News',
            style: GoogleFonts.caveat(
              textStyle: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: Observer(
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              await hackerNews.increaseNewsLimit();
            },
            child: Container(
              child: Observer(
                  builder: (_) => ((hackerNews.news != null) &&
                          (hackerNews.news.isNotEmpty))
                      ? ListView.builder(
                          itemCount: hackerNews.news.length,
                          itemBuilder: (_, index) {
                            final newsAritcle = hackerNews.news[index];
                            return _makeArticleContainer(newsAritcle);
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
          ),
        ),
      );

  Widget _makeArticleContainer(News newsArticle) {
    return Padding(
      key: Key(newsArticle.title),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          newsArticle.title,
          style: GoogleFonts.poppins(fontSize: 16.0),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(newsArticle.type, style: GoogleFonts.oswald(fontSize: 14.0)),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Text('S'),
                ),
                label: Text(newsArticle.score.toString(),
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(color: Colors.indigo),
                        fontSize: 16.0)),
              ),
              Text("by ${newsArticle.by}",
                  style: GoogleFonts.poppins(fontSize: 14.0)),
              IconButton(
                onPressed: () async {
                  if (await canLaunch(newsArticle.url)) {
                    launch(newsArticle.url);
                  }
                },
                icon: Icon(Icons.launch,
                    size: 28.0, color: Colors.deepPurple[700]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
