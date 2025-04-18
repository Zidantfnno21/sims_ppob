import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:sims_popb/config/providers.dart';
import 'package:sims_popb/data/network/dio_interceptor.dart';
import 'package:sims_popb/data/session_manager.dart';
import 'package:sims_popb/feature/splash_screen.dart';

import 'data/network/service/rest_client.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(
      MultiProvider(
        providers: appProviders,
        child: MyApp(),
      )
  );
}

final apiService = RestClient(
    dio: Dio(BaseOptions(
      contentType: "application/json",
      baseUrl: apiDomain,
      followRedirects: false,
    ))
      ..interceptors.add(DioInterceptor(sessionManager: SessionManager()))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      )));

final apiServiceUpload = RestClient(
    dio: Dio(BaseOptions(
      contentType: "multipart/form-data",
      baseUrl: apiDomain,
      followRedirects: false,
    ))
      ..interceptors.add(DioInterceptor(sessionManager: SessionManager()))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      )));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}