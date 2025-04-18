// Rest extension for upload form
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sims_popb/data/network/service/rest_client.dart';

import '../model/profile/profile_response.dart';

extension RestClientExtension on RestClient {
  Future<ProfileResponse> uploadProfileImage(File file) async {

    final fileName = file.path.split('/').last;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    final response = await dio.put(
      '/profile/image',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return ProfileResponse.fromJson(response.data);
  }
}