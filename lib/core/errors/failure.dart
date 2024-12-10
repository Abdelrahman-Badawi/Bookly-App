import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeOut with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeOut with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeOut with ApiServer');
      case DioExceptionType.badCertificate:
       return ServerFailure('Bad certificate from ApiServer');  
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was cancel');
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected erro, Please try again again!');
        default:
        return ServerFailure('Opps There was an error, Please try again!');
    }
   
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later!');
    } else {
      return ServerFailure('Opps There was an error, Please try again!');
    }
  }
}
