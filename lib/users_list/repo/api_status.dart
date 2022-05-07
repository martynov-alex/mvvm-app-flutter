class Success {
  int code;
  Object data;
  Success({required this.code, required this.data});
}

class Failure {
  int code;
  String errorMessage;
  Failure({required this.code, required this.errorMessage});
}
