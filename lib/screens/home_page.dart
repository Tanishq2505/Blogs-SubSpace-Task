import 'package:blogs_task/bloc/home_bloc.dart';
import 'package:blogs_task/bloc/home_bloc_events.dart';
import 'package:blogs_task/bloc/home_bloc_states.dart';
import 'package:blogs_task/bloc/internet_bloc/internet_bloc.dart';
import 'package:blogs_task/bloc/internet_bloc/internet_state.dart';
import 'package:blogs_task/constants.dart';
import 'package:blogs_task/models/blog_data.dart';
import 'package:blogs_task/repository/blog_repository.dart';
import 'package:blogs_task/screens/favourite_blogs_page.dart';
import 'package:blogs_task/widgets/blog_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paginable/paginable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BlogList? blogList;
  bool alreadyFetched = false;
  int elements = 10;
  Map<dynamic, dynamic> favouriteBlogs = {};
  late Box box;

  openBox() async {
    box = await Hive.openBox('favBox');
    favouriteBlogs = await box.get("favouriteArticles") ?? {};
  }

  @override
  void initState() {
    super.initState();
    openBox();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: kBgColor,
      body: BlocListener<InternetBloc, InternetState>(
        listener: (BuildContext context, InternetState state) {
          print(state);
          if (state is NotConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (blogList == null && !alreadyFetched && state is ConnectedState) {
            BlocProvider.of<HomeBloc>(context).add(HomeBlocBlogEvent());
            alreadyFetched = true;
          }
        },
        child: SizedBox(
          height: height,
          width: width,
          child: PaginableCustomScrollView(
            loadMore: () async {
              await Future.delayed(const Duration(seconds: 1));
              if (blogList != null) {
                if (elements + 10 >= blogList!.blogs!.length) {
                  elements = blogList!.blogs!.length;
                } else {
                  elements += 10;
                }
                setState(() {});
              }
            },
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                backgroundColor: kBgColorL2,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => FavouriteBlogsPage(
                              blogList: favouriteBlogs,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.favorite_outline,
                        color: kTextColor,
                      ),
                    ),
                  )
                ],
                title: const Text(
                  "Blogs and Articles",
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              BlocConsumer<HomeBloc, HomeBlocState>(
                builder: (buildContext, state) {
                  print(state);
                  if (state is HomeBlocGetBlogsState && blogList != null) {
                    return SliverList(
                      delegate: PaginableSliverChildBuilderDelegate(
                        (listContext, index) {
                          Blogs currBlog = blogList!.blogs![index];
                          return BlogTile(
                            height: height,
                            width: width,
                            url: currBlog.imageUrl.toString(),
                            title: currBlog.title.toString(),
                            id: currBlog.id.toString(),
                            onPress: () {
                              favouriteBlogs.putIfAbsent(
                                  currBlog.id.toString(), () => currBlog);
                              box.put("favouriteArticles", favouriteBlogs);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Article added to favourites!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          );
                        },
                        childCount: elements,
                        errorIndicatorWidget:
                            (Exception exception, void Function() tryAgain) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Something went wrong!",
                                style: TextStyle(color: kTextColor),
                              ),
                            ),
                          );
                        },
                        progressIndicatorWidget: const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ).build(),
                    );
                  } else if (state is HomeBlocFetchBlogState) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Something went wrong!",
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                      ),
                    );
                  }
                },
                buildWhen: (prev, curr) {
                  if (curr is HomeBlocFetchBlogState ||
                      curr is HomeBlocGetBlogsState) {
                    return true;
                  } else {
                    return false;
                  }
                },
                listener: (BuildContext context, HomeBlocState state) {
                  if (state is HomeBlocGetBlogsState) {
                    blogList = state.blogList;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
