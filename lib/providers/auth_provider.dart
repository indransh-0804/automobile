import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/services/auth_service.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges();
});

final authLoadingProvider = StateProvider<bool>((ref) => false);

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});

class AuthController {
  final Ref _ref;

  AuthController(this._ref);

  Future<void> login(String email, String password) async {
    _ref.read(authLoadingProvider.notifier).state = true;
    try {
      final authService = _ref.read(authServiceProvider);
      await authService.signInWithEmailAndPassword(email, password);
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> logout() async {
    final authService = _ref.read(authServiceProvider);
    await authService.signOut();
  }
}
