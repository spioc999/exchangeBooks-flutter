import 'DataManagerError.dart';

class DataManagerResponse<T>  {

  T response;
  DataManagerError error;

  bool hasError(){
    if(error == null) return false;
    return true;
  }

  bool hasHttpError(){
    if(error == null) return false;
    return error.isHttp ?? false;
  }

}