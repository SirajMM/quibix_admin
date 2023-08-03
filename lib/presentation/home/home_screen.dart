import 'package:admin/domain/models/auth.dart';
import 'package:admin/presentation/Search/search_screen.dart';
import 'package:admin/presentation/home/widgets/order_tiles.dart';
import 'package:admin/presentation/home/widgets/product_tiles.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../add_product/add_new_product.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: kMainBgColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              foregroundColor: Colors.black,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SearchScreen();
                            },
                          ));
                        },
                        icon: const Icon(Icons.search),
                      ),
                      GestureDetector(
                        onTap: () {
                          signOutShowDialog(context);
                        },
                        child: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              ],
              title: const Text(
                "Quibix Admin",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: TabbarHeding(text: 'Products'),
                  ),
                  Tab(
                    child: TabbarHeding(text: 'Orders'),
                  ),
                ],
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            body: const TabBarView(
              children: <Widget>[
                Column(
                  children: [
                    Expanded(
                      child: ProductsTiles(),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
                OrdersTiles(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewProductScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: size.width * 0.28, vertical: 20)),
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> signOutShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out ?'),
          content: const Text('Are you sure you want to sign out ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: kTextBlackColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Auth().signOut1();
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: kTextBlackColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TabbarHeding extends StatelessWidget {
  const TabbarHeding({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
