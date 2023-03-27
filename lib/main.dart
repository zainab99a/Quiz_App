import 'package:flutter/material.dart';
import 'package:quiz/app_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


AppBrain appBrain=AppBrain();
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Quiz App"),
        ),


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: examPage(),
      ),
      ),
    );
  }
}
class examPage extends StatefulWidget {
  @override
  State<examPage> createState() => _examPageState();
}

class _examPageState extends State<examPage> {
  List<Widget>answerList=[];
  int rightAnswer=0;
  void cheackAnswer(bool whatUserPicked){
    bool correctAnswer= appBrain.getQuestionAnswer();
    setState(() {
    if(whatUserPicked==correctAnswer){
      rightAnswer++;
     answerList.add(Padding(
       padding: const EdgeInsets.all(3.0),
       child: Icon(Icons.check,color: Colors.green,),
     ),);
    }
    else{
      answerList.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(Icons.close_rounded,color: Colors.red,),
      ),);
    }

    if(appBrain.isFinished()==true){
      Alert(
        context: context,
        title: "انتهى الاختبار",
        desc: "لقد اجبت على $rightAnswer اسئلة صحيحة من اصل 7 ",
        buttons: [
          DialogButton(
            color: Colors.purple[100],
            child: Text(
              "ابدأ من جديد",
              style: TextStyle(color: Colors.purple, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      appBrain.reset();
      answerList=[];
      rightAnswer=0;
    }
    else{  appBrain.nextQuestion();}

    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children:answerList,
        ),
        Container(
          height: 400.0,
          child: Expanded(
            flex: 10,
                child: Card(
                  margin: EdgeInsets.only(top: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.purple[100],
                  child:Padding(
                    padding: const EdgeInsets.only(left: 16.0,top: 30.0,right: 16.0),
                    child: Column(
                      children: [
                        Image.asset(appBrain.getQuestionImage()),
                       SizedBox(
                         height: 30.0,
                       ),
                                 Center(
                                   child: Text(
                                     textAlign: TextAlign.center,
                                   appBrain.getQuestionText(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,

                                ),
                          ),
                                 ),

                          
                      ],
                    ),
                  ),
                ),
              ),
            ),

        SizedBox(height: 150.0,),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
    backgroundColor:Colors.purple[100],
              foregroundColor: Colors.purple
            ),
              child: Text('صح',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
              onPressed: () {
             cheackAnswer(true);
              }),

            ),



            SizedBox(width: 20.0,),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.purple[100],
                    foregroundColor: Colors.purple
                ),
                child: Text('خطأ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),),
                onPressed: () {
                cheackAnswer(false);
                }

              ),
    ),




      ]

    ),
      ],
    );
}
}








