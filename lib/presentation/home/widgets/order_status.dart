import 'package:flutter/material.dart';

class OrderDetailsActive extends StatelessWidget {
  const OrderDetailsActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: size.width * 0.98,
                  height: size.width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(.5)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/images/images.jpg'),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.64,
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 12.0, top: 0, bottom: 0),
                              child: Text(
                                'Macbooc Pro',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 0, top: 0),
                              child: Text(
                                '12 GB RAM & 512 GB ROM',
                                style: TextStyle(
                                    // overflow: TextOverflow.clip,
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(.5)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0, top: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Silver',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '|',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Nos : 1',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12.0, top: 0, bottom: 0),
                                  child: Text(
                                    '\$ 500',
                                    style: TextStyle(fontSize: 25),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
