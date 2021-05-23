import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'CRUD.dart';

// CLASSE NÃO ESTÁ SENDO USADA, OUTRO METODO FOI IMPLEMENTADO NO LUGAR

class PaginaEnumerarContatos extends StatefulWidget {
  @override
  _PaginaEnumerarContatosState createState() => _PaginaEnumerarContatosState();
}

class _PaginaEnumerarContatosState extends State<PaginaEnumerarContatos> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
      ),
      
    );
  }
}