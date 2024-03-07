import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var lists = [];
const apiHost = 'http://192.168.3.6:3000';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List journals = [];

  Future<void> getJournals() async {
    var url = Uri.parse(apiHost+"/journals");

   var response = await http.get(url);
   var jsonResponse = jsonDecode(response.body);
    setState(() {
      journals = jsonResponse;
    });
  }

  @override
  void initState() {
    super.initState();

    getJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Journals'),
        ),
        body: Material(
          color: const Color(0x4DDDDDDD),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: journals.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(journals[index]['content'].toString()),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // AddPageへ画面遷移する
            pushWithReloadByReturn(context);
          },
          child: const Icon(Icons.add),
        )
    );
  }

  void pushWithReloadByReturn(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPage()),
    );

    // if (result) {
      getJournals();
    // }
  }
}


class AddPage extends StatelessWidget  {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Journal'),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter your Journal'
              ),
              onSubmitted: (String content) {
                // journalを作成する
                addJournal(context, content);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void addJournal(BuildContext context, String content) async {
  var url = Uri.parse(apiHost+"/journals");
  var response = await http.post(url, body: {
    "content": content
  });
  print(response.body);
  // AddPageを閉じて、HomePageに戻る
  Navigator.pop(context, true);
}

// class EditPage extends StatefulWidget {
//   final String id;
//   const EditPage({super.key, this.id});

//   @override
//   State<EditPage> createState() => _EditPageState();
// }

// class _EditPageState extends State<EditPage>  {

//   Map journal = {};

//   Future<void> getJournal() async {
//     var url = Uri.parse("http://localhost:3000/journals/" + widget.id);
//     var response = await http.get(url);
//     var jsonResponse = jsonDecode(response.body);

//     setState(() {
//       journal = jsonResponse;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getJournal();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Journal'),
//       ),
//       body: Material(
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: TextEditingController(text: journal['content'].toString()),
//               decoration: const InputDecoration(
//                 labelText: 'Edit your Journal'
//               ),
//               onSubmitted: (String content) {
//                 // journalを更新する
//                 editJournal(context, content);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void editJournal(BuildContext context, String content) async {
//   var url = Uri.parse("http://localhost:3000/journals");
//   var response = await http.put(url, body: {
//     "content": content
//   });
//   print(response.body);
//   // EditPageを閉じて、HomePageに戻る
//   Navigator.pop(context, true);
// }