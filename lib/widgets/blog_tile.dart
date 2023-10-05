import 'package:blogs_task/constants.dart';
import 'package:blogs_task/screens/blog_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  BlogTile({
    super.key,
    required this.height,
    required this.width,
    required this.url,
    required this.title,
    required this.id,
    this.onPress,
    this.heartDisplayed = true,
  });

  final double height;
  final double width;
  final String url, title, id;
  final Function()? onPress;
  final bool heartDisplayed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => BlogDetailsPage(
              title: title,
              id: id,
              url: url,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: kBgColorL1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    width: width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          10,
                        ),
                        topRight: Radius.circular(
                          10,
                        ),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: url,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) {
                          print(error);
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                  (heartDisplayed)
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: onPress,
                              child: const Icon(
                                Icons.favorite_outline,
                                color: kTextColor,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: SizedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: width * 0.05,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
