import 'package:blogs_task/models/blog_data.dart';

abstract class HomeBlocState {}

// Home bloc initial state
class HomeBlocInitialState extends HomeBlocState {}

// To call and fetch the blogs
class HomeBlocFetchBlogState extends HomeBlocState {}

// To get all the blocs on home screen
class HomeBlocGetBlogsState extends HomeBlocState {
  BlogList blogList;
  HomeBlocGetBlogsState(this.blogList);
}

class HomeBlocErrorBlogState extends HomeBlocState {
  String msg;
  HomeBlocErrorBlogState(this.msg);
}
