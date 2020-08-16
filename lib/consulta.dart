import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Consulta extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}


class _ConsultaState extends State<Consulta> {

  Firestore _db = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  
  List<String> cadastros = new List();


  Future<List<String>>_getCadastros() async {
    cadastros = new List();
    QuerySnapshot querySnapshot = await _db.collection('pessoa').getDocuments();
    for (DocumentSnapshot item in querySnapshot.documents) {
      cadastros.add(item.data['nome'].toString() + " - " + item.data['idade'].toString());
    }
    return cadastros;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _getCadastros(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done :
              if (snapshot.hasError) {
                print("Erro ao carregar lista");
              } else {
                print("Lista careegada com sucesso");
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List<String> list = snapshot.data;
                    String item = list[index];
                    return ListTile(
                      title: Text(item),
                    );
                  }
                );
              }
          }
        },
      ),
    );
  }
}
