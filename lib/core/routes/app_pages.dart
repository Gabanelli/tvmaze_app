import 'package:get/get.dart';

abstract class AppPages {
  static final List<GetPage> _pages = [];
  static String? _initialPage;

  static void registerPages(List<GetPage> pages) {
    _pages.addAll(pages);
  }

  static List<GetPage> get pages => _pages;

  static String get initialPage {
    assert(_initialPage != null, 'No initial page was provided');
    return _initialPage!;
  }

  static set initialPage(value) => _initialPage = value;
}
