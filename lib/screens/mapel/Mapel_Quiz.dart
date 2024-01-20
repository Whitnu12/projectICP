import 'package:flutter/material.dart';

class QuizInputPage extends StatefulWidget {
  @override
  _QuizInputPageState createState() => _QuizInputPageState();
}

class _QuizInputPageState extends State<QuizInputPage> {
  List<Widget> questionWidgets = [];
  TextEditingController quizNameController = TextEditingController();

  void addQuestion() {
    int questionIndex = questionWidgets.length + 1;
    Widget questionWidget =
        QuestionWidget(key: UniqueKey(), questionNumber: questionIndex);
    setState(() {
      questionWidgets.add(questionWidget);
    });
  }

  @override
  void initState() {
    super.initState();
    // Start with one question input
    addQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: quizNameController,
              decoration: InputDecoration(
                hintText: 'Nama Quiz',
              ),
            ),
          ),
          Column(
            children: questionWidgets,
          ),
          ElevatedButton(
            onPressed: addQuestion,
            child: Text('Tambah Soal'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the save action
              saveQuiz();
            },
            child: Text('Selesai'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void saveQuiz() {
    // Implementasi penyimpanan quiz
    print('Nama Quiz: ${quizNameController.text}');
    // for (int i = 0; i < questionWidgets.length; i++) {
    //   QuestionWidget questionWidget = questionWidgets[i] as QuestionWidget;
    //   print('Soal ${i + 1}: ${questionWidget.getQuestionText()}');
    // }
  }
}

class QuestionWidget extends StatefulWidget {
  final int questionNumber;

  QuestionWidget({required Key key, required this.questionNumber})
      : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late int _groupValue;
  TextEditingController questionController = TextEditingController();
  List<TextEditingController> answerControllers = [];

  @override
  void initState() {
    super.initState();
    _groupValue = -1;
    answerControllers = List.generate(4, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Soal ${widget.questionNumber}',
                style: Theme.of(context).textTheme.headline6),
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                hintText: 'Masukkan Soal',
              ),
            ),
            ...List<Widget>.generate(4, (index) {
              return Column(
                children: [
                  TextField(
                    controller: answerControllers[index],
                    decoration: InputDecoration(
                      hintText: 'Jawaban ${index + 1}',
                    ),
                  ),
                  RadioListTile(
                    value: index,
                    groupValue: _groupValue,
                    onChanged: (newValue) {
                      setState(() {
                        _groupValue = newValue!;
                      });
                    },
                    title: Text('Pilih jawaban ini sebagai benar'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  getQuestionText() {
    return questionController.text;
  }
}
