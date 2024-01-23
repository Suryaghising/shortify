import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shortify/enums/response_status.dart';
import 'package:shortify/errors/exceptions.dart';
import 'package:shortify/repositories/shortify_repository.dart';
import 'package:shortify/utils/network_info.dart';

class ShortifyController {

  late ShortifyRepository shortifyRepository;

  initData() {
    final connectionChecker = InternetConnectionChecker();
    final dio = Dio();
    final networkInfo = NetworkInfoImpl(connectionChecker: connectionChecker);
    shortifyRepository = ShortifyRepositoryImpl(networkInfo: networkInfo, dio: dio);
  }

  Future<ResponseStatus> getShortedLink(String url) async{
    try {
      final response = await shortifyRepository.getShortedLink(url);
      return ResponseSuccess(response);
    } on NoInternetException catch (e) {
      return const ResponseFailure('Please check your internet connection and try again.');
    }
    on DioException catch (e) {
      return ResponseFailure(e.response?.data['message'] ?? 'Something went wrong.');
    } catch (e) {
      return const ResponseFailure('Something went wrong.');
    }
  }
}