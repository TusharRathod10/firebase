// import 'package:flutter/material.dart';
//
// class DemoScreen extends StatefulWidget {
//   const DemoScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DemoScreen> createState() => _DemoScreenState();
// }
//
// class _DemoScreenState extends State<DemoScreen> {
//   List<String> items = List.generate(20, (index) => 'item${index}');
//   ScrollController scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             controller: scrollController,
//             child: Column(
//               children: [
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: items.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) => Container(
//                     height: 50,
//                     width: 300,
//                     margin: EdgeInsets.all(10),
//                     color: Colors.lightBlueAccent,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text('${items[index]}')
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 70,
//                 )
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               children: [
//                 Flexible(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.grey),
//                   ),
//                 ),
//                 FloatingActionButton(onPressed: () {
//                   scrollController.animateTo(
//                       scrollController.position.maxScrollExtent,
//                       duration: Duration(milliseconds: 200),
//                       curve: Curves.easeIn);
//                 }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class SwipeToDeleteDemo extends StatefulWidget {
//   @override
//   State<SwipeToDeleteDemo> createState() => _SwipeToDeleteDemoState();
// }
//
// class _SwipeToDeleteDemoState extends State<SwipeToDeleteDemo> {
//   List<String> _items = List.generate(20, (index) => "Item ${index + 1}");
//
//   void _deleteItem(int index) {
//     setState(() {
//       _items.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Swipe to delete'),
//       ),
//       body: ListView.builder(
//         itemCount: _items.length,
//         itemBuilder: (context, index) {
//           final item = _items[index];
//           return Dismissible(
//             key: Key(item),
//             direction: DismissDirection.endToStart,
//             background: Container(
//               color: Colors.red,
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 20.0),
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                     size: 30.0,
//                   ),
//                 ),
//               ),
//             ),
//             onDismissed: (direction) {
//               _deleteItem(index);
//             },
//             child: ListTile(
//               title: Text(item),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//  Select item and delete

// import 'package:flutter/material.dart';
//
// class SelectAndDeleteDemo extends StatefulWidget {
//   @override
//   State<SelectAndDeleteDemo> createState() => _SelectAndDeleteDemoState();
// }
//
// class _SelectAndDeleteDemoState extends State<SelectAndDeleteDemo> {
//   List<String> _items = List.generate(20, (index) => "Item ${index + 1}");
//   Set<int> _selectedItems = Set<int>();
//
//   void _deleteSelectedItems() {
//     setState(() {
//       _items
//           .removeWhere((item) => _selectedItems.contains(_items.indexOf(item)));
//       _selectedItems.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select and delete'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: _selectedItems.isEmpty
//                 ? null
//                 : () {
//                     _deleteSelectedItems();
//                   },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _items.length,
//         itemBuilder: (context, index) {
//           final item = _items[index];
//           return ListTile(
//             title: Text(item),
//             leading: Checkbox(
//               value: _selectedItems.contains(index),
//               onChanged: (value) {
//                 setState(() {
//                   if (value!) {
//                     _selectedItems.add(index);
//                   } else {
//                     _selectedItems.remove(index);
//                   }
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class LongPressToDeleteDemo extends StatefulWidget {
//   @override
//   State<LongPressToDeleteDemo> createState() => _LongPressToDeleteDemoState();
// }
//
// class _LongPressToDeleteDemoState extends State<LongPressToDeleteDemo> {
//   List<String> _items = List.generate(20, (index) => "Item ${index + 1}");
//
//   void _deleteItem(int index) {
//     setState(() {
//       _items.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Long-press to delete'),
//       ),
//       body: ListView.builder(
//         itemCount: _items.length,
//         itemBuilder: (context, index) {
//           final item = _items[index];
//           return ListTile(
//             title: Text(item),
//             onLongPress: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Delete item?'),
//                   content: Text('Are you sure you want to delete this item?'),
//                   actions: <Widget>[
//                     MaterialButton(
//                       child: Text('Cancel'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     MaterialButton(
//                       child: Text('Delete'),
//                       onPressed: () {
//                         _deleteItem(index);
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyApp2 extends StatefulWidget {
  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  // Define a list to hold the items

  List<Map> firebasedata = [];

  List<Map<String, dynamic>> _items = List.generate(
      5,
          (index) => {
        'name': 'item $index',
        'selected': false,
      });

  // Define a set to hold the indices of the selected items


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Long Press and Select Demo'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index]['name']),
            // Add a long press gesture recognizer
            onLongPress: () {
              setState(() {
                if (_items[index]['selected'] == true) {
                  _items[index]['selected'] = false;
                } else {
                  _items[index]['selected'] = true;
                }
              });
              // setState(() {
              //   // Toggle the selection status of the item
              //   if (_selectedIndices.contains(index)) {
              //     _selectedIndices.remove(index);
              //   } else {
              //     _selectedIndices.add(index);
              //   }
              // });
            },
            // Display a check mark icon for selected items
            trailing:
            _items[index]['selected'] == true ? Icon(Icons.check) : null,
          );
        },
      ),
      // Display a button to delete the selected items
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          var toRemove = [];

          _items.forEach((element) {
            if (element['selected'] == true) {
              toRemove.add(element);
            }
          });

          _items.removeWhere((e) => toRemove.contains(e));

          setState(() {});
        },
      ),
    );
  }
}
