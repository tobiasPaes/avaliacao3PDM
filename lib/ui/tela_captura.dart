// ignore_for_file: unused_local_variable, unused_field

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<int> rand = [];




  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    for(int i=0; i<6; i++){
      num = Random().nextInt(1017);
      rand.add(num);
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
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      ],
    );
  }
}
