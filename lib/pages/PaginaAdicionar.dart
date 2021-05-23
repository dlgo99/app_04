import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'CRUD.dart';

class PaginaAdicionar extends StatefulWidget {
  @override
  _PaginaAdicionarState createState() => _PaginaAdicionarState();
}

class _PaginaAdicionarState extends State<PaginaAdicionar> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllernome       = TextEditingController();
    TextEditingController _controlleremail      = TextEditingController();
    TextEditingController _controllerendereco   = TextEditingController();
    TextEditingController _controllercep        = TextEditingController();
    TextEditingController _controllertelefone   = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Contato"),
      ),
      body: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          img ('assets/images/enumerar128.png'),
          TextField(
              decoration: InputDecoration(
                labelText: "Digite o Nome: ",
              ),
              controller: _controllernome,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o e-mail: ",
              ),
              controller: _controlleremail,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o Endereco: ",
              ),
              controller: _controllerendereco,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o CEP: ",
              ),
              controller: _controllercep,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o Telefone: ",
              ),
              controller: _controllertelefone,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                        child: Text("Adicionar"),
                        onPressed: () async {
                          if (campoVazios(_controllernome.text, _controlleremail.text, _controllerendereco.text, 
                              _controllercep.text, _controllertelefone.text) == false){
                            //if(true){
                            adicionar(_controllernome.text, _controlleremail.text, 
                            _controllerendereco.text, _controllercep.text, _controllertelefone.text);
                            await getID();
                            print("Contato $idGlobal Adicionado");  
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Contato $idGlobal Adicionado!"),
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        print("OK");
                                      }
                                    )
                                  ],
                                );
                              },
                            );                     
                          }
                          else {
                            print("Não pode ter campos vazios");
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Não pode ter campos vazios"),
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        print("OK");
                                      }
                                    )
                                  ],
                                );
                              },
                            );  
                          }
                    }
                    ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}