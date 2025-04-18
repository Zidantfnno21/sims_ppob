import 'dart:async';

import 'package:flutter/material.dart';
import 'session_manager.dart';

class SessionProvider extends ChangeNotifier {
  final SessionManager _sessionManager = SessionManager();
  Timer? _logoutTimer;

  bool _isLoggedIn = false;
  bool _initialized = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _initialized;

  SessionProvider() {
    _init();
  }

  Future<void> _init() async {
    _isLoggedIn = await _sessionManager.isTokenValid();
    _initialized = true;

    if (_isLoggedIn) {
      _startTokenExpiryTimer();
    }

    notifyListeners();
  }

  void _startTokenExpiryTimer() async {
    final expiry = await _sessionManager.getTokenExpiry();
    if (expiry == null) return;

    final now = DateTime.now();
    final duration = expiry.difference(now);

    _logoutTimer?.cancel();
    _logoutTimer = Timer(duration, () {
      logout();
    });
  }

  Future<void> login(String token) async {
    await _sessionManager.saveToken(token);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _sessionManager.clearSession();
    _isLoggedIn = false;
    notifyListeners();
  }
}
