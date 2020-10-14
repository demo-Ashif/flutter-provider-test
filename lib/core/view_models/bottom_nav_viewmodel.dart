import 'package:footsapp/core/base/base_viewmodels/base_viewmodel.dart';

class BottomNavViewModel extends BaseViewModel {
  BottomNavViewModel({int pageIndex}) {
    _currentIndex = pageIndex ?? 0;
  }

  int _currentIndex = 0;

  int get currentPage => _currentIndex;

  set currentPage(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  //for speed-dial FAB purpose
  bool _showMenus;

  bool get showMenus => _showMenus;

  set showGameTypeMenus(bool showMenus) {
    showMenus = showMenus;
    notifyListeners();
  }
}
