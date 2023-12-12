import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/news_category_controller.dart';
import 'package:news_app/controller/news_headllines_controller.dart';
import 'package:news_app/model/news_category_model.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:news_app/view/category_screen.dart';
import 'package:news_app/view/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, cnnNews, alJazeeraNews, abcNews, foxNews }

class _HomeScreenState extends State<HomeScreen> {
  NewsHeadlinesController newsHeadlinesController = NewsHeadlinesController();
  NewsCategoryController newsCategoryController = NewsCategoryController();

  final dateFormat = DateFormat("MMMM dd, yyyy");
  FilterList? selectedFilter;
  Map<String, String> sources = {
    'bbcNews': 'bbc-news',
    'aryNews': 'ary-news',
    'cnnNews': 'cnn-news',
    'alJazeeraNews': 'al-jazeera-english',
    'abcNews': 'abc-news',
    'foxNews': 'fox-news',
  };
  String channelName = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("News",
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: Image.asset("assets/images/category_icon.png",
              height: 20, width: 20, fit: BoxFit.contain),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryScreen()));
          },
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedFilter,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                channelName = sources[item.name]!;
                setState(() {
                  newsHeadlinesController.getNewsHeadlines(channelName);
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text("BBC News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.aryNews,
                      child: Text("Ary News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.alJazeeraNews,
                      child: Text("Al Jazeera News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.cnnNews,
                      child: Text("CNN News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.foxNews,
                      child: Text("Fox News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.abcNews,
                      child: Text("ABC News"),
                    )
                  ]),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsHeadlinesModel>(
              future: newsHeadlinesController.getNewsHeadlines(channelName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50,
                  ));
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              title: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              imageUrl: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              date: dateFormat.format(
                                                  DateTime.parse(snapshot
                                                      .data!
                                                      .articles![index]
                                                      .publishedAt
                                                      .toString())),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString(),
                                            )));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * 0.02),
                                height: height * 0.6,
                                width: width * 0.9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SpinKitCircle(
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          )),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  height: height * 0.19,
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ),
                                                Text(
                                                    dateFormat.format(
                                                        DateTime.parse(snapshot
                                                            .data!
                                                            .articles![index]
                                                            .publishedAt
                                                            .toString())),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                }
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder<NewsCategoryModel>(
                future: newsCategoryController.getNewsByCategory('general'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            title: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            description: snapshot.data!
                                                .articles![index].description
                                                .toString(),
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            date: dateFormat.format(
                                                DateTime.parse(snapshot
                                                    .data!
                                                    .articles![index]
                                                    .publishedAt
                                                    .toString())),
                                            author: snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            source: snapshot.data!
                                                .articles![index].source!.name
                                                .toString(),
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              height: height * 0.2,
                              width: width,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: CachedNetworkImage(
                                        height: height * 0.2,
                                        width: width * 0.3,
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const SpinKitCircle(
                                              color: Colors.blue,
                                              size: 50,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                              size: 60,
                                            )),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                                snapshot.data!.articles![index]
                                                    .description
                                                    .toString(),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                )),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ),
                                                Text(
                                                    dateFormat.format(
                                                        DateTime.parse(snapshot
                                                            .data!
                                                            .articles![index]
                                                            .publishedAt
                                                            .toString())),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
