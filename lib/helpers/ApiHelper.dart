class ApiHelper{
  static bool isSuccessfulResponse(int code) {
    if(code == null) return true;
    return code == 0 || code == 200;
  }
}