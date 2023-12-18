import 'package:pszczoly_v3/models/question.dart';

//all questions will be changed to eng or the app fully pl? voice to text in pl?

List<Question> checklistQuestions = [
  Question(text: 'Odkład (tak/nie)', responseType: ResponseType.yesNo),
  Question(text: 'Półnadstawka nr 1 (%)', responseType: ResponseType.percentage),
  Question(text: 'Półnadstawka nr 2 (%)', responseType: ResponseType.percentage),
  Question(text: 'Półnadstawka nr 3 (%)', responseType: ResponseType.percentage),
  Question(text: 'Półnadstawka: woda (%)', responseType: ResponseType.percentage),
  Question(text: 'Stan ramki pracy: odbudowana komórka trutowa (tak/nie)', responseType: ResponseType.yesNo),

];