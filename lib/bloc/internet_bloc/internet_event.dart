// Internet bloc parent event class
abstract class InternetEvent {}

// Internet connection successfull event
class OnConnectedEvent extends InternetEvent {}

// Internet connection  notconnected event
class OnNotConnected extends InternetEvent {}
