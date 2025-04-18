import 'package:dio/dio.dart';
import 'package:sims_popb/data/session_manager.dart';

class DioInterceptor extends Interceptor {
  final SessionManager sessionManager;

  DioInterceptor({required this.sessionManager});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sessionManager.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}