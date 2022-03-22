import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain quizBrian=QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900 ,
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            )),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper=[];
  List<AlertType> showResult=[];
  void checkAnswer(bool userpickAnswer){

    bool correctAnswer=quizBrian.getCorrectAnswer();
    setState(()
    {
      if(quizBrian.isfinished()==true)
        {
          Alert(context: context,
 /*           type: AlertType.info,*/
            title: "Quiz Result",
          desc: "you\'ve reached the end of quiz.",).show();
          quizBrian.reset();
          scorekeeper.clear();
        }
      else{
        if(userpickAnswer==correctAnswer)
        {
          scorekeeper.add(Icon(Icons.check,
            color: Colors.green,),);
          quizBrian.result();
        }
        else{
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,)
          );
          quizBrian.result();
        }

      quizBrian.nextQuestion();
       }
      }
     );

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrian.getQuestionText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),),
            ),
          ),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text('True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),),
              onPressed: (){
                checkAnswer(true);
                },
            ),
            ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text('False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: (){
                //The user Picked true.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
