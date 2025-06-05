import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/servicio_autenticacion.dart';


class AuthProvider extends ChangeNotifier {
  final ServicioAutenticacion _authService = ServicioAutenticacion();
  User? _user;
  User? get user => _user;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<User?> signInWithGoogle() async {
    final user = await _authService.signInWithGoogle();
    _user = user;
    notifyListeners();
    return user;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}