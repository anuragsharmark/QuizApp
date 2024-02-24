import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_app/questionsModal.dart';
import 'package:quiz_app/screens.dart/answerScreen.dart';

class quizScreen extends StatefulWidget {
  const quizScreen({super.key});

  @override
  State<quizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {
  List<question> questionList = getquestionList();
  int questionIndex = 0;
  int score = 0;
  answer? selectedAnswer;

  _nextButton() {
    bool IslastQuestion = false;

    if (questionIndex == questionList.length - 1) {
      IslastQuestion = true;
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 45,
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor:
              IslastQuestion ? Colors.blue : Color.fromRGBO(148, 141, 113, 1),
          foregroundColor: Colors.black,
        ),
        onPressed: () {
          if (IslastQuestion) {
            _scoreScreen();
          } else {
            setState(() {
              selectedAnswer = null;
              questionIndex++;
            });
          }
        },
        child: Text(
          IslastQuestion ? 'Submit' : 'Next',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  _scoreScreen() {
    double Ispass = (score / questionList.length) * 100;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                ' Your Score is ${score.toString()}/${questionList.length.toString()}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              new CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: (score / questionList.length),
                header: Text(
                  Ispass > 40.0 ? 'Pass' : 'Fail',
                  style: TextStyle(
                      fontSize: 18,
                      color: Ispass > 40.0 ? Colors.green : Colors.red),
                ),
                center: Text(
                  ((score / questionList.length) * 100).toStringAsFixed(1) +
                      '%',
                  style: TextStyle(
                      color: Ispass > 40.0 ? Colors.green : Colors.red,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.grey,
                progressColor: Ispass > 40.0 ? Colors.green : Colors.red,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          questionIndex = 0;
                          score = 0;
                          selectedAnswer = null;
                        });

                        Navigator.of(context).pop();
                      },
                      child: Text('Retest')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => answerScreen(),
                            ));
                      },
                      child: Text('View Answers')),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _questionsWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: double.infinity,
            child: Text(
              'Question no. ${questionIndex + 1}/${questionList.length}',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
              color: Color.fromRGBO(247, 164, 158, 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Text(
              questionList[questionIndex].questionText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }

  _answerWidget() {
    return Column(
        children: questionList[questionIndex]
            .answerList
            .map(
              (e) => answerWidget(e),
            )
            .toList());
  }

  Widget answerWidget(answer answer) {
    bool isSelected = answer == selectedAnswer;
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 45,
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor:
              isSelected ? Color.fromRGBO(247, 164, 158, 1) : Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
          }
          setState(() {
            selectedAnswer = answer;
          });
        },
        child: Text(
          answer.answerText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 238, 237, 1),
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Quiz',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
          )),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          width: double.infinity,
          child: Text(
            'This is our whole quiz ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _questionsWidget(),
        _answerWidget(),
        SizedBox(
          height: 10,
        ),
        _nextButton(),
      ]),
    );
  }
}
