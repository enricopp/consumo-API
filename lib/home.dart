import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
      ),
      body: FutureBuilder<dynamic>(
        future: pegarUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var usuario = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(usuario['id'].toString()),
                    ),
                    title: Text(usuario['name']),
                    subtitle: Text(usuario['website']),
                  );
                });
          } else if (snapshot.hasError) ;
          {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  pegarUsuarios() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      return jsonDecode(resposta.body);
    } else {
      throw Exception('Não foi possivel carregar');
    }
  }
}
