import 'package:flutter/material.dart';
import 'package:newsapi/Controller/getData.dart';
import 'package:newsapi/Design/news_card.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);

    getData!.getNewsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text('Awesome News App'),
      ),
      body: Consumer<GetData>(builder: (context, data, child) {
        return data.newsListModel != null
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Text('${data.newsListModel!.totalResults} News fetched'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.newsListModel!.articles!.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            image:
                                data.newsListModel!.articles![index].urlToImage,
                            title: data.newsListModel!.articles![index].title,
                            date:
                                data.newsListModel!.articles![index].publishedAt,
                            description:
                                data.newsListModel!.articles![index].description,
                            author: data.newsListModel!.articles![index].author,
                          );
                        })
                  ],
                ),
            )
            : CircularProgressIndicator();
      }),
    );
  }
}
