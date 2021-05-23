import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

int idGlobal = 0;   // sempre muda
int id = 0;  // muda dependendo do que for preciso
bool validado = false;
String lista = "Nada na lista";

receberId(String x) {
  id = int.parse(x);
  print("Recebido ID: $id");
}

  img(var imagem){
    return Image.asset(
      imagem,
      //    width: 100,
      // height: 100,
      fit: BoxFit.fill,
    );
  }

  textInfo(var mensagem) {
    return Text(
      mensagem,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 18.0),
    );
  }

  bool campoVazio(String a, String b) {
    bool resp = false;
    if (a.isEmpty || b.isEmpty) {
      resp = true;
    }
    return resp;
  }

  bool campoVazios(String a, String b, String c, String d, String e) {
    bool resp = false;
    if (a.isEmpty || b.isEmpty || c.isEmpty || d.isEmpty || e.isEmpty) {
      resp = true;
    }
    return resp;
  }

    CollectionReference cadastro = FirebaseFirestore.instance.collection('cadastro');
    CollectionReference agenda = FirebaseFirestore.instance.collection('agenda');
    CollectionReference nextID = FirebaseFirestore.instance.collection('nextID');
    
    cadastrar(String login, String senha) {
      return cadastro
          .add({
            'login': login,
            'senha': senha,
            'excluido': false,
          })
          .then((value) => print("Usuario Cadastrado"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    adicionar(String nome, String email, String endereco, String cep, String telefone) async {
      await getID();
      await setID();
      return agenda
          .doc(idGlobal.toString())
          .set({
            'id': idGlobal,
            'nome': nome,
            'email': email,
            'endereco': endereco,
            'cep': cep,
            'telefone': telefone,
            'excluido': false,
          })
          .then((value) => print("Contato Adicionado"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    atualizar(String nome, String email, String endereco, String cep, String telefone) {
      return agenda
        .doc(id.toString())
        .update({
            'nome': nome,
            'email': email,
            'endereco': endereco,
            'cep': cep,
            'telefone': telefone,
            'excluido': false,
            })
        .then((value) => print("Contato Atualizado"))
        .catchError((error) => print("Failed to update user: $error"));
}

excluir() {
      return agenda
        .doc(id.toString())
        .update({'excluido': true,})
        .then((value) => print("Contato Excluido"))
        .catchError((error) => print("Failed to update user: $error"));
}

lerTodos() async {
  //print(doc["id"] + doc["nome"] + doc["email"] + doc["endereco"] + doc["cep"] + doc["telefone"]);
  lista = "";
    await FirebaseFirestore.instance
    .collection('agenda')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            //print(doc["id"] + doc["nome"] + doc["email"] + doc["endereco"] + doc["cep"] + doc["telefone"]);
            lista = (""+lista+"\nID: " + doc["id"].toString() + "\nNome: " + doc["nome"]  + "\nE-mail: " + doc["email"] + 
            "\nEndereco: " + doc["endereco"]  + "\nCep: " + doc["cep"]  + "\nTelefone: " + doc["telefone"] 
            + "\n");
        }
        );
    });
}

getID() async {
    await FirebaseFirestore.instance
    .collection('nextID')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            idGlobal = (doc["id"]);
            idGlobal++;
        }
        );
    });
}

setID() {
      return nextID
        .doc("id")
        .update({
            'id': ++idGlobal
            })
        .then((value) => print("Contato Atualizado"))
        .catchError((error) => print("Failed to update user: $error"));
}

validarConta(String x, String y) async {
    validado = false;
    await FirebaseFirestore.instance
    .collection('cadastro')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            if (x == doc["login"] && y == doc["senha"])
              validado = true;
        }
        );
    });
}

validarLogin(String x) async {
    validado = false;
    await FirebaseFirestore.instance
    .collection('cadastro')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            if (x == doc["login"])
              validado = true;
        }
        );
    });
}

validarID() async {
    validado = false;
    await FirebaseFirestore.instance
    .collection('agenda')
    .where('excluido', isEqualTo: false)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            if (id == doc["id"])
              validado = true;
        }
        );
    });
}