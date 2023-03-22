import 'package:auto_route/auto_route.dart';
import '../screens/searchScreen/search_screen.dart';
import '../screens/favoriteScreen/favorite_screen.dart';
import '../screens/detailesScreen/detailes_screen.dart';
import '../screens/homeScreen/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: "Screen,Route",
  routes: [
    AutoRoute(
      page: HomeScreen,
      initial: true,
    ),
    AutoRoute(
      page: DetailesScreen,
    ),
    AutoRoute(
      page: FavoriteScreen,
    ),
    AutoRoute(
      page: SearchScreen,
    ),
  ],
)
class $AppRouter {}
