import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blogs_task/bloc/home_bloc.dart';
import 'package:blogs_task/bloc/home_bloc_events.dart';
import 'package:blogs_task/bloc/home_bloc_states.dart';
import 'package:blogs_task/bloc/internet_bloc/internet_event.dart';
import 'package:blogs_task/bloc/internet_bloc/internet_state.dart';
import 'package:blogs_task/repository/blog_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? subscription;
  InternetBloc() : super(InitState()) {
    // check Internet status automatically using package and emit state according to result
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      // if internet is working properly
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        add(
          OnConnectedEvent(),
        );
      }
      // if internet is not working
      else {
        add(
          OnNotConnected(),
        );
      }
    });
    // Add event when internet  is connected
    on<OnConnectedEvent>((event, emit) async {
      HomeBloc().add(HomeBlocBlogEvent());
      emit(
        ConnectedState("Connected...."),
      ); // emit to show success toast message
    });
    on<OnNotConnected>((event, emit) async {
      emit(
        NotConnectedState("Not Connected....."),
      ); // emit to show error toast message
    });
  }
}
