enum ResponseType {
  yesNo,
  text,
  percentage,
  number,
}

class Question {
  String id;
  String text;
  ResponseType responseType;
  dynamic response;

  Question({
    required this.id,
    required this.text,
    required this.responseType,
    this.response,
  });
}
