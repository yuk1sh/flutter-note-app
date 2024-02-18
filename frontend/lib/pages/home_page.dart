import 'package:flutter/material.dart';

var lists = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Notes'),
      ),
      body: Material(
        child: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(lists[index]),
              onTap: () {
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
        child: const Icon(Icons.add),
      )
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter your note'
              ),
              onSubmitted: (String value) {
                lists.add(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}