import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'PaginaEnumerarContatos.dart';
import 'CRUD.dart';
import 'PaginaAdicionar.dart';
import 'paginaEditar.dart';

class PaginaLogado extends StatefulWidget {
  @override
  _PaginaLogadoState createState() => _PaginaLogadoState();
}

class _PaginaLogadoState extends State<PaginaLogado> {
  List _listaCompras = ["Pão", "Leite", "Manteiga"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Contatos"),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, //usar com o BottomNavigationBar
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          elevation: 6,
          child: Icon(Icons.update),
          onPressed: () async {
            lista = "\n";
            await lerTodos();
            print("Botão pressionado!");
            print ("Botão: ------------ \n"+lista);
            showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text(lista),
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
      ),
      body: Column(
        children: <Widget>[
          img ('assets/images/logado.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                        child: Text("Adicionar"),
                        onPressed: () async{
                            print("-> Pagina Adicionar");
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaginaAdicionar()
                                ),
                              );
                        });       
                        }
                    ),
              Padding(padding: EdgeInsets.all(10.0),),
              ElevatedButton(
                        child: Text("Editar"),
                        onPressed: () async{
                            print("-> Pagina Editar");
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaginaEditar()
                                ),
                              );
                        });       
                        }
                    ),
            ],
          ),
          //textInfo(lista),
          /*
          Expanded(
            child: ListView.builder(
                itemCount: _listaCompras.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_listaCompras[index]),
                  );
                }
            ),
          ),
          */
        ],
      ),


      /*bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
                icon:Icon(Icons.add) ,
                onPressed: (){
                }
            ),
          ],
        ),

      ),*/
    );
  }
}
