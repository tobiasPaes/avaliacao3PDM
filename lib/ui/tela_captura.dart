// ignore_for_file: unused_local_variable, unused_field, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/list_item.dart';

class TelaCaptura extends StatefulWidget {
  const TelaCaptura({super.key});

  @override
  State<TelaCaptura> createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int num = 0;
  List<int> rand = [1, 1, 1, 1, 1, 1];
  late Future<Map<String, dynamic>> nomesPoke;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    setState(() {
      nomesPoke = getDadosPokeApi();
    });
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    for (int i = 0; i < 6; i++) {
      num = Random().nextInt(1017);
      rand[i] = num;
    }
  }

  Future<Map<String, dynamic>> getDadosPokeApi() async {
    try {
      final res = await http.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0'));
      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexao';
      }
      final data = jsonDecode(res.body);
      // print(data['results']);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('nao foi possivel conectar ', error: e);
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _connectionStatus == ConnectivityResult.none
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Voce esta sem conexao com a internet'),
                  Text('tente se conectar para ter acesso aos pokemon'),
                ],
              ),
            )
          : FutureBuilder(
              future: nomesPoke,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                final data = snapshot.data!;
                final name = data['results'][rand[0]]['name'];

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListItem(
                          id: rand[0], name: data['results'][rand[0]]['name']),
                      ListItem(
                          id: rand[1], name: data['results'][rand[1]]['name']),
                      ListItem(
                          id: rand[2], name: data['results'][rand[2]]['name']),
                      ListItem(
                          id: rand[3], name: data['results'][rand[3]]['name']),
                      ListItem(
                          id: rand[4], name: data['results'][rand[4]]['name']),
                      ListItem(
                          id: rand[5], name: data['results'][rand[5]]['name']),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
/*
      body: _conectado
          ? ListView.builder(
              itemCount: _pokemonsDisponiveis.length,
              itemBuilder: (context, index) {
                return _buildPokemonCard(_pokemonsDisponiveis[index]);
              },
            )
          : const Center(
              child: Text('Sem conexão com a Internet'),
            ),
    );
  }
*/
