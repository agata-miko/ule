enum ResponseType {
  yesNo,
  text,
  percentage,
  number,
}

class Question {
  String text;
  ResponseType responseType;
  dynamic response;

  Question({
    required this.text,
    required this.responseType,
    this.response,
  });
}
