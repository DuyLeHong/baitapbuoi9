import 'package:baitapbuoi5/Models/product_list_controller.dart';
import 'package:baitapbuoi5/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/total_cartitem.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartTotal(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductListController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class Routes {
  static final String product = "/product";
  static final String detail = "/detail";
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: Routes.product,
      routes: {
        Routes.product: (context) => ProductList(),
      },
    );
  }
}
