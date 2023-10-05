// Internet bloc parent state class
import 'package:dio/dio.dart';

abstract class InternetState {}

// Internet bloc firstTime call state  class
class InitState extends InternetState {}

// Internet connection is  successfully to show this  toast message  then emit this state
class ConnectedState extends InternetState {
  String msg;
  ConnectedState(this.msg);
}

// Internet connection is  not found to show this  toast message then emit this state
class NotConnectedState extends InternetState {
  String msg;
  NotConnectedState(this.msg);
}
