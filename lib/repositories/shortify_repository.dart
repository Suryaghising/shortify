import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shortify/errors/exceptions.dart';
import 'package:shortify/utils/constants.dart';
import 'package:shortify/utils/network_info.dart';

import '../models/shortify.dart';

abstract class ShortifyRepository {
  Future<Shortify> getShortedLink(String url);
}

class ShortifyRepositoryImpl implements ShortifyRepository {
  final NetworkInfo networkInfo;
  final Dio dio;

  ShortifyRepositoryImpl({required this.networkInfo, required this.dio});

  @override
  Future<Shortify> getShortedLink(String url) async {
    if(await networkInfo.isConnected) {
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "apikey": kApiKey,
      };

      final formRequest = jsonEncode({
        'destination': url,
        'domain': {'fullName': kDomain}
      });

      final response = await dio.post('$kBaseUrl/links',
          data: formRequest, options: Options(headers: headers));
      final data = response.data;
      return Shortify.fromJson(data);
    } else {
      throw NoInternetException();
    }
  }
}
