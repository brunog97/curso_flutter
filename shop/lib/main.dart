import 'package:flutter/material.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'pages/product_page.dart';

void main() {
  //setUrlStrategy(PathUrlStrategy());
  runApp(
    // Envolvendo a aplicação com 1 Provider ChangeNotifierProvider, quando for mais de um é MultiProvider
    MultiProvider(
      providers: [
        //Provider de autenticação deve ser o primeiro
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (context, auth, previousProductList) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previousProductList?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (context, value, previous) {
            return OrderList(
              value.token ?? '',
              value.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      //create: (_) => ProductList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        //home: ProductsOverviewPage(),
        routes: {
          //AppRoutes.home: (ctx) => ProductsOverviewPage(),
          AppRoutes.productDetail: (ctx) => ProductDetailPage(),
          AppRoutes.cart: (ctx) => CartPage(),
          AppRoutes.orders: (ctx) => OrdersPage(),
          AppRoutes.products: (ctx) => ProductPage(),
          AppRoutes.productform: (ctx) => ProductFormPage(),
          AppRoutes.auth_or_home: (ctx) => AuthOrHomePage(),
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('pt', 'BR'),
        ],
      ),
    ),
  );
}
