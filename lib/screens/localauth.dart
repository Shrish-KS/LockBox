import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


class LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;
  bool justauth=false;


  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics().whenComplete(() => {
        authenticate()
      });
    } catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    _availableBiometrics=availableBiometrics;
  }

  Future<void> authenticate() async {
    justauth=true;
    try {
      await auth.authenticate(
        localizedReason: 'Verify Your identity',
        options: const AuthenticationOptions(
          stickyAuth: true
        ),
      );
    } catch (e) {
      print(e);
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold()
    );
  }
}