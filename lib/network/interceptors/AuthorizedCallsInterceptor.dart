import 'package:dio/dio.dart';
import 'package:exchange_books/data_managers/DataManager.dart';
import 'package:exchange_books/routes/Routes.dart';
import 'package:exchange_books/values/HttpConstants.dart';
import 'package:sailor/sailor.dart';

class AuthorizedCallsInterceptor extends Interceptor{

  String _authorization;
  Dio apiClient;

  ///
  AuthorizedCallsInterceptor(
      this._authorization,
      this.apiClient);


  @override
  Future onRequest(RequestOptions options) {
    options.headers[HttpConstants.authorizationHeader] = HttpConstants.bearer + " " + _authorization;
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) async{
    if (err.type !=  DioErrorType.RESPONSE)
      return super.onError(err);

    if(err.response?.statusCode == 403){

      DataManager dm = DataManager();

      await dm.managerUser.logout();

      Routes.sailor.navigate(Routes.login, navigationType: NavigationType.pushAndRemoveUntil, removeUntilPredicate: (_) => false);





      //qui si potrebbe inserire una logica per la gestione del refreshing del token
    }
  }
}