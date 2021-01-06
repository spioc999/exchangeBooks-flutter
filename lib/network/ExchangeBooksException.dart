class ExchangeBooksException implements Exception{
  int code = 0;
  String message;
  bool isHttp = false;
  Exception innerException;
  StackTrace stackTrace;

  ExchangeBooksException(this.code, this.message, {this.isHttp = false});

  ExchangeBooksException.withInner(
      this.code, this.message, this.innerException, this.stackTrace);

  String toString() {
    if (message == null && code == 0) return "ExchangeBooksException";

    if (message == null) return "ExchangeBooksException $code";

    if (innerException == null) {
      return "ExchangeBooksException $code: $message";
    }

    return "ExchangeBooksException $code: $message (Inner exception: $innerException)\n\n" +
        stackTrace.toString();
  }
}