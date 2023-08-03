import 'package:admin/application/orders/order_provider.dart';
import 'package:admin/application/search/serch_provide.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'application/add_product_provider/add_product_provider.dart';
import 'constants/constants.dart';
import 'presentation/home/home_screen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddProductProvider>(
            create: (_) => AddProductProvider()),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        title: 'Quibix Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryBlack,
        ),
        home: const ScreenHome(),
      ),
    );
  }
}
