import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../widgets/gesture.dart';

class OnBoardingBloc {
  /// Output stream
  final BehaviorSubject<int> _activeIndex = BehaviorSubject<int>.seeded(0);

  Stream<int> get activeIndex => _activeIndex.stream;

  /// Input stream
  final StreamController<int> _indexController = StreamController<int>();

  Sink<int> get index => _indexController.sink;

  final _event = BehaviorSubject<Swipe>();

  Stream<Swipe> get eventStream => _event.stream;

  final _eventController = StreamController<Swipe>();

  Sink<Swipe> get event => _eventController.sink;

  OnBoardingBloc() {
    _indexController.stream.listen((i) => _updateIndex(i));
    _eventController.stream.listen((event) => _addEvent(event));
  }

  void _addEvent(Swipe event) {
    // print('$event');
    _event.add(event);
  }

  void update(index) => _updateIndex(index);

  void _updateIndex(newIndex) => _activeIndex.add(newIndex);

  void dispose() {
    _activeIndex.close();
    _indexController.close();
    _event.close();
    _eventController.close();
  }
}
