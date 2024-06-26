import 'package:get/get.dart';
import 'package:trinity_wizard/views/home/home_view.dart';
import 'package:trinity_wizard/views/home/home_view_model.dart';

class RouteConstant {
  RouteConstant._();

  static const String home = '/home';
}

class RouteCollections {
  RouteCollections._();

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: RouteConstant.home,
      page: () => const HomeView(),
      binding: BindingsBuilder<HomeViewModel>(
        () => Get.lazyPut(() => HomeViewModel()),
      ),
    ),
    /*GetPage<dynamic>(
      name: RouteConstant.searchArticle,
      page: () => const SearchArticleView(),
      binding: BindingsBuilder<SearchArticleViewModel>(
        () => Get.lazyPut(() => SearchArticleViewModel()),
      ),
    ),
    GetPage<dynamic>(
      name: RouteConstant.articleList,
      page: () => const ArticleListView(),
      binding: BindingsBuilder<ArticleListViewModel>(
        () => Get.lazyPut(() => ArticleListViewModel()),
      ),
    ),*/
  ];
}
