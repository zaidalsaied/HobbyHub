import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:hobby_hub_ui/network/socket/chat.dart';

class DependencyInjection {
  Injector initialise(Injector injector) {
    injector.map<SocketService>((i) => SocketService(), isSingleton: true);
    return injector;
  }
}