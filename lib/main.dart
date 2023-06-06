import "package:flutter/material.dart";
import 'package:logger/logger.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

const List<String> colorList = <String>['Black', 'Red', 'White', 'Pink'];
const List<String> sizeList = <String>['XS', 'S', 'L', 'XL', 'XXL', 'XXXL'];

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool favoriteActive = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Details Page',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(400),
          child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.unsplash.com/photo-1609357605129-26f69add5d6e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.keyboard_return_outlined,
                  color: Colors.black),
              tooltip: 'Return Back',
              onPressed: () {
                logger.d("Back clicked");
              },
            ),
            title: const Text('Product Details Page',
                style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    favoriteActive = !favoriteActive;
                  });
                },
                tooltip: 'Toggle Favorite',
                icon: favoriteActive
                    ? const Icon(Icons.favorite_border_outlined,
                        color: Colors.black)
                    : const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              children: [
                DropDownButtons(),
                ProductDescription(),
              ],
            ),
          ),
        ),
        /* bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(label: 'Buy', icon: Icon(Icons.shop)),
            BottomNavigationBarItem(
                label: 'Add a bag', icon: Icon(Icons.help_outline))
          ],
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
        ),*/
      ),
    );
  }
}

class DropDownButtons extends StatefulWidget {
  const DropDownButtons({super.key});

  @override
  State<DropDownButtons> createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  String colorDropDownValue = colorList.first;
  String sizeDropDownValue = sizeList.first;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: colorDropDownValue,
            elevation: 16,
            isExpanded: true,
            underline: Container(
              height: 2,
              color: const Color.fromARGB(255, 151, 148, 160),
            ),
            onChanged: (String? value) {
              setState(() {
                colorDropDownValue = value!;
              });
            },
            items: colorList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: DropdownButton<String>(
            value: sizeDropDownValue,
            isExpanded: true,
            elevation: 16,
            underline: Container(
              height: 2,
              color: const Color.fromARGB(255, 151, 148, 160),
            ),
            onChanged: (String? value) {
              setState(() {
                sizeDropDownValue = value!;
              });
            },
            items: sizeList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class ProductDescription extends StatefulWidget {
  const ProductDescription({super.key});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  var _rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kapka Valour',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        RatingBar(
                          minRating: 1,
                          maxRating: 5,
                          initialRating: 0,
                          allowHalfRating: true,
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                          itemSize: 30,
                          glow: false,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          ratingWidget: RatingWidget(
                              empty: const Icon(
                                Icons.star_border,
                                color: Colors.grey,
                              ),
                              half: const Icon(Icons.star_half,
                                  color: Color(0xFFFDCC0D)),
                              full: const Icon(
                                Icons.star,
                                color: Color(0xFFFDCC0D),
                              )),
                        ),
                        Text(
                          '$_rating stars',
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(width: 10),
                  ),
                  const Text(
                    '\$50000',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const Text(
            'Dave watched as the forest burned up on the hill, only a few miles from her house. The car had been hastily packed and Marta was inside trying to round up the last of the pets. Dave went through his mental list of the most important papers and documents that they couldn\'t leave behind. He scolded himself for not having prepared these better in advance and hoped that he had remembered everything that was needed. He continued to wait for Marta to appear with the pets, but she still was nowhere to be seen.'),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('You clicked on Buy button')));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.all(20)),
                child: const Text('Buy'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text('Add a bag'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int _currentIndex = 0;
//   List<Widget> 

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
