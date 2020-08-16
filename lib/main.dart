import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/cadastro.dart';
import 'package:firebase_app/consulta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  Firestore db = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;*/

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Cadastro de Pessoa"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.assignment_ind),
            ),
            Tab(
              icon: Icon(Icons.assignment),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Cadastro(),
          Consulta()
        ],
      ),
    );
  }
}

