class APIResult {
  int code;
  String error;
  bool succeed;
  dynamic data;

  APIResult(
      {this.code = 200, this.data, this.succeed = false, this.error = ''});

  bool noInternet() => code == -1;

  bool isSuccessful() => succeed;

  bool isFailed() => !succeed;
}
