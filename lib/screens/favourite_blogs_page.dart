import 'package:blogs_task/constants.dart';
import 'package:blogs_task/models/blog_data.dart';
import 'package:blogs_task/widgets/blog_tile.dart';
import 'package:flutter/material.dart';

class FavouriteBlogsPage extends StatefulWidget {
  Map<dynamic, dynamic> blogList;
  FavouriteBlogsPage({Key? key, required this.blogList}) : super(key: key);

  @override
  State<FavouriteBlogsPage> createState() => _FavouriteBlogsPageState();
}

class _FavouriteBlogsPageState extends State<FavouriteBlogsPage> {
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
              "Favourite Articles",
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (widget.blogList.isNotEmpty) {
                  List<dynamic> blogFinalList = widget.blogList.values.toList();
                  Blogs currBlog = blogFinalList[index];
                  return BlogTile(
                    height: height,
                    width: width,
                    url: currBlog.imageUrl.toString(),
                    title: currBlog.title.toString(),
                    id: currBlog.id.toString(),
                    heartDisplayed: false,
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "No articles added to favourite!",
                        style: TextStyle(color: kTextColor),
                      ),
                    ),
                  );
                }
              },
              childCount:
                  (widget.blogList.isEmpty) ? 1 : widget.blogList.length,
            ),
          ),
        ],
      ),
    );
  }
}
