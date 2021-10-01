import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat/gAw9bnfmMNReklETerAB/messages')
                .snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = streamSnapshot.data.docs;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      documents[index]['text'],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('chat/gAw9bnfmMNReklETerAB/messages')
                      .add({'text': 'new data added'});
                }),
          ],
        )
    );
  }
}
