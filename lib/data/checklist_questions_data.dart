import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pszczoly_v3/models/question.dart';

List<Question> getChecklistQuestions(BuildContext context) {
  return [
    Question(id: 'q1', text: AppLocalizations.of(context)!.q1, responseType: ResponseType.yesNo),
    Question(id: 'q2', text: AppLocalizations.of(context)!.q2, responseType: ResponseType.percentage),
    Question(id: 'q3', text: AppLocalizations.of(context)!.q3, responseType: ResponseType.percentage),
    Question(id: 'q4', text: AppLocalizations.of(context)!.q4, responseType: ResponseType.percentage),
    Question(id: 'q5', text: AppLocalizations.of(context)!.q5, responseType: ResponseType.percentage),
    Question(id: 'q6', text: AppLocalizations.of(context)!.q6, responseType: ResponseType.yesNo),
    Question(id: 'q7', text: AppLocalizations.of(context)!.q7, responseType: ResponseType.yesNo),
    Question(id: 'q8', text: AppLocalizations.of(context)!.q8, responseType: ResponseType.yesNo),
    Question(id: 'q9', text: AppLocalizations.of(context)!.q9, responseType: ResponseType.yesNo),
    Question(id: 'q10', text: AppLocalizations.of(context)!.q10, responseType: ResponseType.yesNo),
    Question(id: 'q11', text: AppLocalizations.of(context)!.q11, responseType: ResponseType.text),
    Question(id: 'q12', text: AppLocalizations.of(context)!.q12, responseType: ResponseType.text),
    Question(id: 'q13', text: AppLocalizations.of(context)!.q13, responseType: ResponseType.text),
    Question(id: 'q14', text: AppLocalizations.of(context)!.q14, responseType: ResponseType.text),
    Question(id: 'q15', text: AppLocalizations.of(context)!.q15, responseType: ResponseType.text),
    Question(id: 'q16', text: AppLocalizations.of(context)!.q16, responseType: ResponseType.text),
    Question(id: 'q17', text: AppLocalizations.of(context)!.q17, responseType: ResponseType.text),
    Question(id: 'q18', text: AppLocalizations.of(context)!.q18, responseType: ResponseType.text),
    Question(id: 'q19', text: AppLocalizations.of(context)!.q19, responseType: ResponseType.percentage),
    Question(id: 'q20', text: AppLocalizations.of(context)!.q20, responseType: ResponseType.percentage),
    Question(id: 'q21', text: AppLocalizations.of(context)!.q21, responseType: ResponseType.yesNo),
    Question(id: 'q22', text: AppLocalizations.of(context)!.q22, responseType: ResponseType.text),
    Question(id: 'q23', text: AppLocalizations.of(context)!.q23, responseType: ResponseType.text),
    Question(id: 'q24', text: AppLocalizations.of(context)!.q24, responseType: ResponseType.yesNo),
    Question(id: 'q25', text: AppLocalizations.of(context)!.q25, responseType: ResponseType.text),
  ];
}