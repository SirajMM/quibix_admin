import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

int _selectedButton = 1;
ScrollController _scrollController1 = ScrollController();
List<String> items1 = [
  'Item 1',
  'Item 1',
  'Item 1',
  'Item 1',
  'Item 1',
  'Item 1',
  'Item 1',
  'Item 1',
  // Add more items here
];
List<String> items2 = [
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  'Item 2',
  // Add more items here
];
List<String> items3 = [
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  'Item 3',
  // Add more items here
];

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButton = 1;
                      _scrollToPosition(
                          0); // Scroll to the start of the first section
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedButton == 1 ? Colors.blue : Colors.black,
                  ),
                  child: const Text("Button 1"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButton = 2;
                      _scrollToPosition(items1
                          .length); // Scroll to the start of the second section
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedButton == 2 ? Colors.blue : Colors.black,
                  ),
                  child: const Text("Button 2"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButton = 3;
                      _scrollToPosition(items1.length +
                          items2
                              .length); // Scroll to the start of the third section
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedButton == 3 ? Colors.blue : Colors.black,
                  ),
                  child: const Text("Button 3"),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                controller: _scrollController1,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 55 * items1.length.toDouble(),
                        child: ListView.builder(
                          controller: _scrollController1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items1.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(items1[index]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55 * items2.length.toDouble(),
                        child: ListView.builder(
                          controller: _scrollController1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items2.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(items2[index]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55 * items3.length.toDouble(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items3.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(items3[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToPosition(int position) {
    _scrollController1.animateTo(
      position * 55.0, // Assuming each item has a height of 55.0
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController1.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Calculate the current section index based on the scroll position
    int sectionIndex = (_scrollController1.position.pixels / 55.0).floor();
    int items1Length = items1.length;
    int items2Length = items2.length;
    

    if (sectionIndex <= items1Length) {
      setState(() {
        _selectedButton = 1;
      });
    } else if (sectionIndex <= items1Length + items2Length) {
      setState(() {
        _selectedButton = 2;
      });
    } else {
      setState(() {
        _selectedButton = 3;
      });
    }
  }
}
