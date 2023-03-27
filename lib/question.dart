class Question{
  late String questionText;
  late String questionImage;
  late bool questionAnswer;

  Question({ required String q,required String i,required bool a}){
    questionText=q;
    questionImage=i;
    questionAnswer=a;
  }
}