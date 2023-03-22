// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../screens/detailesScreen/detailes_screen.dart' as _i2;
import '../screens/favoriteScreen/favorite_screen.dart' as _i3;
import '../screens/homeScreen/home_screen.dart' as _i1;
import '../screens/searchScreen/search_screen.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    DetailesRoute.name: (routeData) {
      final args = routeData.argsAs<DetailesRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.DetailesScreen(
          key: args.key,
          imageId: args.imageId,
          title: args.title,
        ),
      );
    },
    FavoriteRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.FavoriteScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SearchScreen(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          DetailesRoute.name,
          path: '/detailes-screen',
        ),
        _i5.RouteConfig(
          FavoriteRoute.name,
          path: '/favorite-screen',
        ),
        _i5.RouteConfig(
          SearchRoute.name,
          path: '/search-screen',
        ),
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.DetailesScreen]
class DetailesRoute extends _i5.PageRouteInfo<DetailesRouteArgs> {
  DetailesRoute({
    _i6.Key? key,
    required int imageId,
    required String title,
  }) : super(
          DetailesRoute.name,
          path: '/detailes-screen',
          args: DetailesRouteArgs(
            key: key,
            imageId: imageId,
            title: title,
          ),
        );

  static const String name = 'DetailesRoute';
}

class DetailesRouteArgs {
  const DetailesRouteArgs({
    this.key,
    required this.imageId,
    required this.title,
  });

  final _i6.Key? key;

  final int imageId;

  final String title;

  @override
  String toString() {
    return 'DetailesRouteArgs{key: $key, imageId: $imageId, title: $title}';
  }
}

/// generated route for
/// [_i3.FavoriteScreen]
class FavoriteRoute extends _i5.PageRouteInfo<void> {
  const FavoriteRoute()
      : super(
          FavoriteRoute.name,
          path: '/favorite-screen',
        );

  static const String name = 'FavoriteRoute';
}

/// generated route for
/// [_i4.SearchScreen]
class SearchRoute extends _i5.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search-screen',
        );

  static const String name = 'SearchRoute';
}
