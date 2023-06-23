import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/add_product_provider/add_product_provider.dart';
import 'constants/constants.dart';
import 'presentation/widgets/login_or_home/login_or_home.dart';

Future<void> main() async {
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
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryBlack,
        ),
        home: const LoginOrSignIn(),
      ),
    );
  }
}
