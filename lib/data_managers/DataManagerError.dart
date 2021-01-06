class DataManagerError {
  String errorType;
  String message;
  int status;
  bool isHttp;

  static const String ERR_CACHE = "Not Found in Cache";
  static const String ERR_CACHE_WRITE = "Can't write in Cache";
  static const String ERR_CACHE_DELETE = "Can't delete from Cache";
}