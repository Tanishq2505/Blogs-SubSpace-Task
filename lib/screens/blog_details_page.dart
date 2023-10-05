import 'package:blogs_task/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BlogDetailsPage extends StatefulWidget {
  String title;
  String id;
  String url;
  BlogDetailsPage({
    Key? key,
    required this.title,
    required this.id,
    required this.url,
  }) : super(key: key);

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: kBgColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            foregroundColor: kTextColor,
            snap: true,
            floating: true,
            backgroundColor: kBgColorL2,
            title: Text(
              "Blog Insights",
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: height * 0.25,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        width: width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.url,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) {
                            print(error);
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0),
                              Colors.black.withOpacity(0.25),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.75),
                              Colors.black.withOpacity(0.9),
                            ],
                            begin: const Alignment(0.25, -1.0),
                            end: const Alignment(-0.25, 1),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: width * 0.05,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Text(
                loremIpsum,
                style: TextStyle(
                  color: kTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
