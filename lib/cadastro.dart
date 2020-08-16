import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _nome = new TextEditingController();
  TextEditingController _idade = new TextEditingController();

  Firestore _db = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final String _collection = "pessoa";

  EdgeInsets _paddingField() {
    return EdgeInsets.only(bottom: 10);
  }

  void _cleanFields() {
    _nome.clear();
    _idade.clear();
  }

  void _salvar (String nome, int idade) async {
    _db.collection(_collection).add({
      "nome": nome,
      "idade": idade
    }).catchError((error) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Erro"),
          content: Text("Ocorreu um erro: " + error.toString()),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
              },
            )
          ],
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Pessoa"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: _paddingField(),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Nome'),
                  keyboardType: TextInputType.text,
                  controller: _nome,
                )
            ),
            Padding(
              padding: _paddingField(),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Idade'),
                keyboardType: TextInputType.number,
                controller: _idade,
              ),
            ),
            Padding(
                padding: _paddingField(),
                child: RaisedButton(
                  child: Text("Salvar"),
                  onPressed: () {
                    setState(() {
                      _salvar(_nome.text, int.parse(_idade.text));
                      showDialog(
                        context: context,
                        builder: (BuildContext build) {
                          return AlertDialog(
                            title: Text("Sucesso"),
                            content: Text("Salvo com sucesso"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  _cleanFields();
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                      );
                    });
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
