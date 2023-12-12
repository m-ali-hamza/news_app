import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  String imageUrl;
  String title;
  String description;
  String date;
  String author;
  String source;
  DetailScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.date,
      required this.author,
      required this.source});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat("MMMM dd, yyyy");

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News Detail",
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: height * 0.45,
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                    errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        )),
              ),
            ),
            Container(
              height: height * 0.6,
              margin: EdgeInsets.only(top: height * 0.44),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              decoration: const BoxDecoration(color: Colors.white),
              child: ListView(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(source,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                      ),
                      Text(date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
