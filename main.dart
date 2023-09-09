import 'package:calclator/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  var userQuestion = '';
  var userAnswer = '';
 final List<String> buttons = [
   'C','DEL','%','/',
   '9','8','7','x',
   '6','5','4','-',
   '3','2','1','+',
   '0','.','00','=',
 ];
  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor:Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[100],
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Text(userQuestion,style: TextStyle(fontSize: 35),)),

                    Container(
                      padding:  EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(userAnswer,style: TextStyle(fontSize: 35),))
                  ],
                ),
              )
          ),
          Expanded(
            flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder:(BuildContext context,int index){
                 if (index == 0){
                   return MyButton(
                       color: Colors.green,
                       buttonText: buttons[index],
                       textColor:Colors.white,
                     buttonTapped:(){
                         setState(() {
                           userQuestion = '';
                           userAnswer = '';
                         });
                   },);
                 }else if(index == 1){
                   return MyButton(
                       color: Colors.red,
                       buttonText: buttons[index],
                       textColor:Colors.white, buttonTapped:(){
                         setState(() {
                           userQuestion = userQuestion.substring(0,userQuestion.length-1);
                         });
                   },);
                 }
                 else if(index == buttons.length-1){
                   return MyButton(
                     color: Colors.deepPurple,
                     buttonText: buttons[index],
                     textColor:Colors.white, buttonTapped:(){
                     setState(() {
                       equalPressed();
                     });
                   },);
                 }

                 else{
                   return MyButton(
                     buttonTapped: (){
                       setState(() {
                         userQuestion = userQuestion+buttons[index];
                       });
                     },
                       color:isOperator(buttons[index])? Colors.deepPurple: Colors.deepPurple[50],
                       buttonText: buttons[index],
                       textColor:isOperator(buttons[index]) ? Colors.white:Colors.deepPurple);
                 }
                    }),
              ),
          ),
        ],
      ),
    );
  }

 bool isOperator(String x){
   if(x == '%'|| x == '/' || x == '-'|| x == 'x' || x == '+' || x == '='){
     return true;
   }
   return false;
 }
 void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
   Parser p = Parser();
   Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
 }
}