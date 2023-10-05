import 'package:bloc/bloc.dart';
import 'package:blogs_task/models/blog_data.dart';
import 'package:blogs_task/repository/blog_repository.dart';
import 'package:dio/dio.dart';

import 'home_bloc_events.dart';
import 'home_bloc_states.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(HomeBlocInitialState()) {
    on<HomeBlocBlogEvent>((event, emit) async {
      emit(HomeBlocFetchBlogState());
      try {
        Response response = await BlogRepository().getBlogs();
        if (response.statusCode! > 199 && response.statusCode! < 300) {
          emit(
            HomeBlocGetBlogsState(
              BlogList.fromJson(response.data),
            ),
          );
        } else {
          emit(
            HomeBlocErrorBlogState("Something went wrong!"),
          );
        }
      } catch (ex) {
        emit(
          HomeBlocErrorBlogState("Something went wrong!$ex"),
        );
      }
    });
  }
}
