import 'package:pszczoly_v3/models/question.dart';

//all questions will be changed to eng or the app fully pl? voice to text in pl?

List<Question> getChecklistQuestions() {
  return [
    Question(id: 'q1', text: 'Odkład', responseType: ResponseType.yesNo),
    Question(id: 'q2', text: 'Półnadstawka nr 1', responseType: ResponseType.percentage),
    Question(id: 'q3', text: 'Półnadstawka nr 2', responseType: ResponseType.percentage),
    Question(id: 'q4', text: 'Półnadstawka nr 3', responseType: ResponseType.percentage),
    Question(id: 'q5', text: 'Półnadstawka: woda', responseType: ResponseType.percentage),
    Question(id: 'q6', text: 'Stan ramki pracy: odbudowana komórka trutowa', responseType: ResponseType.yesNo),
    Question(id: 'q7', text: 'Stan ramki pracy: odbudowana komórka czerw.', responseType: ResponseType.yesNo),
    Question(id: 'q8', text: 'Stan ramki pracy: brak odbudowy', responseType: ResponseType.yesNo),
    Question(id: 'q9', text: 'Stan ramki pracy: usunięto zabudowanie?', responseType: ResponseType.yesNo),
    Question(id: 'q10', text: 'Mateczniki', responseType: ResponseType.yesNo),
    Question(id: 'q11', text: 'Czerw zasklepiony (szt.)', responseType: ResponseType.text),
    Question(id: 'q12', text: 'Jakość czerwiu', responseType: ResponseType.text),
    Question(id: 'q13', text: 'Stan pokarmu w 1/1 (szt.)', responseType: ResponseType.text),
    Question(id: 'q14', text: 'Stan pierzgi w 1/1', responseType: ResponseType.text),
    Question(id: 'q15', text: 'Odebrane ramki z czerwiem (szt.)', responseType: ResponseType.text),
    Question(id: 'q16', text: 'Odebrane ramki z pokarmem (szt.)', responseType: ResponseType.text),
    Question(id: 'q17', text: 'Odebrane ramki z pierzgą (szt.)', responseType: ResponseType.text),
    Question(id: 'q18', text: 'Dołożone ramki z węzą (szt.)', responseType: ResponseType.text),
    Question(id: 'q19', text: 'Stan nowych ramek z węzą: odbudowane', responseType: ResponseType.percentage),
    Question(id: 'q20', text: 'Stan nowych ramek z węzą: zaczerwione', responseType: ResponseType.percentage),
    Question(id: 'q21', text: 'Matka: widziana', responseType: ResponseType.yesNo),
    Question(id: 'q22', text: 'Matka: rasa', responseType: ResponseType.text),
    Question(id: 'q23', text: 'Matka: kolor opalitka', responseType: ResponseType.text),
    Question(id: 'q24', text: 'Nastrój rojowy', responseType: ResponseType.yesNo),
    Question(id: 'q25', text: 'Siła rodziny', responseType: ResponseType.text),
  ];
}