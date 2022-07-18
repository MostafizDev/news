import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatefulWidget {
  final String? image;
  final String? title;
  final String? date;
  final String? description;
  final String? author;

  const NewsCard(
      {Key? key,
      this.image,
      this.title,
      this.date,
      this.description,
      this.author})
      : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: Image.network(
                      widget.image.toString(),
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title.toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(widget.date.toString()),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ReadMoreText(
                widget.description.toString(),
                trimLines: 5,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'See less',
                lessStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
                moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  Text('by '),
                  InkWell(
                      onTap: () {
                        _launchInBrowser(Uri.parse(widget.author.toString()));
                      },
                      child: Text(
                        '${widget.author}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
