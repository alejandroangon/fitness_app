import 'dart:convert';
import 'package:flutter/material.dart';
import '../data/session.dart';
import '../data/sp_helper.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  List<Session> sessions = [];
  final TextEditingController txtDescripition = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sesiones'),
      ),
      body: ListView(children: getContent()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {showSessionDialog(context)},
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Insert training session'),
            content: SingleChildScrollView(
                child: Column(children: [
              TextField(
                  controller: txtDescripition,
                  decoration: const InputDecoration(hintText: 'Description')),
              TextField(
                  controller: txtDuration,
                  decoration: const InputDecoration(hintText: 'Duration'))
            ])),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    txtDescripition.text = '';
                    txtDuration.text = '';
                  },
                  child: const Text('Cancel')),
              ElevatedButton(onPressed: saveSession, child: Text('Save'))
            ],
          );
        });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    int id = helper.getCounter() + 1;
    Session newSession = Session(
        id, today, txtDescripition.text, int.tryParse(txtDuration.text) ?? 0);
    helper.writeSession(newSession).then((_) {
      updateScreen();
      helper.setCounter();
    });
    txtDuration.text = '';
    txtDescripition.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> titles = [];
    sessions.forEach((session) {
      titles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          helper.deleteSession(session.id).then((value) => {updateScreen()});
        },
        child: ListTile(
          title: Text(session.description),
          subtitle: Text('${session.date} - duration: ${session.duration} min'),
        ),
      ));
    });
    return titles;
  }

  void updateScreen() {
    sessions = helper.getSessions();
    setState(() {});
  }
}
