import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  List buku = [];
  Future<void> ambildata() async {
    final response =
        await http.get(Uri.parse("http://192.168.0.104/bukuapi/read.php"));
    if (response.statusCode == 200) {
      setState(() {
        buku = json.decode(response.body);
        print(buku);
      });
    } else {
      print("gagal mendapat data");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpustakaan"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: buku.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: ListTile(
                      title: Text(buku[index]['nama_buku']),
                      subtitle: Text(buku[index]['kode_buku']+" - "+buku[index]['pembuat']),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () {}),
    );
  }
}
