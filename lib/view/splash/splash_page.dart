// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:hafleh/core/blocs/auth/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: SplashPage());

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),
        () => {context.read<AuthBloc>().add(SplashLoaded())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Center(
            child: SizedBox(
                height: 121,
                width: 121,
                child: Lottie.asset(
                  'assets/lottie/loading.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ))));
  }
}
