import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controller/news_headllines_controller.dart';
import 'package:news_app/model/news_headlines_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsHeadlinesController newsHeadlinesController = NewsHeadlinesController();
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
              height: 30, width: 30, fit: BoxFit.contain),
          onPressed: () {},
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsHeadlinesModel>(
              future: newsHeadlinesController.getNewsHeadlines(),
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02),
                              height: height * 0.6,
                              width: width * 0.9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage!
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SpinKitCircle(
                                          color: Colors.blue,
                                          size: 50,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        )),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                height: height * 0.1,
                                alignment: Alignment.bottomCenter,
                                child: Column(children: []),
                              ),
                            )
                          ],
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
