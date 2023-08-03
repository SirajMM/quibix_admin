import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

int _selectedCategoryIndex = 0;
List<String> categories = ['Category 1', 'Category 2', 'Category 3'];
List<String> items1 = [
  'Item 1',
  'Item 1',
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
];

// Calculate the height of each item in the list based on its content
double itemHeight = 55.0;

class _TestState extends State<Test> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_onScroll);
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Calculate the index of the item currently at the top of the visible area
    int index = (_scrollController!.offset / itemHeight).floor();

    // Calculate the number of items that can be displayed on the screen
    int visibleItemCount =
        (_scrollController!.position.viewportDimension / itemHeight).ceil();

    // Determine the last visible item index
    int lastVisibleItemIndex = index + visibleItemCount - 1;

    // Check if the last visible item is the last item in the entire list
    int lastItemIndex = items1.length + items2.length + items3.length - 3;
    bool reachedEnd = lastVisibleItemIndex >= lastItemIndex;

    // Update the selected category index when scrolling to a new item
    if (reachedEnd) {
      // Select the last category button
      setState(() {
        _selectedCategoryIndex = categories.length - 1;
      });
    } else {
      // Only update the selected category index if it is not already the current index
      if (_selectedCategoryIndex != index) {
        setState(() {
          _selectedCategoryIndex = index;
        });
      }
    }
  }

  void _scrollToCategory(int index) {
    // Scroll to the selected category item
    _scrollController!.animateTo(
      itemHeight,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable Categories'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // List of ElevatedButtons representing categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              categories.length,
              (index) => ElevatedButton(
                onPressed: () {
                  _scrollToCategory(index);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedCategoryIndex == index
                      ? Colors.blue
                      : Colors.grey,
                ),
                child: Text(categories[index]),
              ),
            ),
          ),
          // Scrollable list of items
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: itemHeight * items1.length,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items1.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(items1[index]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: itemHeight * items2.length,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items2.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(items2[index]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: itemHeight * items3.length,
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
    );
  }
}
