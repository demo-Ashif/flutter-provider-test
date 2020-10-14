import 'package:flutter/widgets.dart';
import 'package:footsapp/core/enums/viewstate.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Initial;

  ViewState get state => _state;

  String errorMessage = '';

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
