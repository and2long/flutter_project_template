import 'dart:async';

class EventBus {
  StreamController? _streamController;
  static EventBus? _singleton;

  factory EventBus() {
    _singleton ??= EventBus._internal();
    return _singleton!;
  }

  EventBus._internal() {
    _streamController = StreamController.broadcast();
  }

  Stream<T> on<T>() {
    if (T == dynamic) {
      return _streamController!.stream as Stream<T>;
    } else {
      return _streamController!.stream.where((event) => event is T).cast<T>();
    }
  }

  void fire<T>(T event) {
    _streamController!.sink.add(event);
  }
}
