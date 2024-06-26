import 'package:get/get.dart';
import 'package:trinity_wizard/views/home/home_view.dart';
import 'package:trinity_wizard/views/home/home_view_model.dart';
import 'package:trinity_wizard/views/login/login_view.dart';
import 'package:trinity_wizard/views/login/login_view_model.dart';
import 'package:trinity_wizard/views/my_contacts/my_contacts_view_model.dart';
import 'package:trinity_wizard/views/my_profile/my_profile_view_model.dart';

class RouteName {
  RouteName._();

  static const String home = '/home';
  static const String login = '/login';
}

class RouteCollections {
  RouteCollections._();

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: RouteName.home,
      page: () => const HomeView(),
      binding: BindingsBuilder<HomeViewModel>(
        () => Get.lazyPut(() => HomeViewModel()),
      ),
      bindings: <Bindings>[
        BindingsBuilder<MyContactsViewModel>(() {
          Get.lazyPut<MyContactsViewModel>(
            () => MyContactsViewModel(),
          );
        }),
        BindingsBuilder<MyProfileViewModel>(() {
          Get.lazyPut<MyProfileViewModel>(
            () => MyProfileViewModel(),
          );
        }),
      ],
    ),
    GetPage<dynamic>(
      name: RouteName.login,
      page: () => const LoginView(),
      binding: BindingsBuilder<LoginViewModel>(() {
        Get.lazyPut<LoginViewModel>(
          () => LoginViewModel(),
        );
      }),
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
