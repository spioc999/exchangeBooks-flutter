import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:exchange_books/network/interceptors/BaseOptionsInterceptor.dart';
import 'package:exchange_books/network/interceptors/InterceptorFactory.dart';

class InterceptorSetter {

  static void setInterceptors(Dio client, String hostUrl, List<Interceptor> interceptors){
    //client.transformer = FlutterTransformer(); //json transformation in background
    //setting base options
    client.interceptors.add(BaseOptionsInterceptor(hostUrl));
    client.interceptors.addAll(interceptors);
    //adding logger interceptor for debugging
    client.interceptors.add(InterceptorFactory.createLoggerInterceptor());
  }

}