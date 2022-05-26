import 'package:flutter/material.dart';
import 'package:util/screens/loan&due/credit_screen.dart';
import 'package:util/screens/loan&due/loan_screen.dart';
import 'package:util/screens/loan&due/widgets/loan_due_widget.dart';

class LoanDue extends StatefulWidget {
  const LoanDue({Key? key}) : super(key: key);

  @override
  _LoanDueState createState() => _LoanDueState();
}

class _LoanDueState extends State<LoanDue> {

  PageController _pageController = PageController(initialPage: 0);
  int current_index=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,

            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                )
            ),


          ),*/


      body: PageView(
      controller: _pageController,
      onPageChanged: (index){
        setState(() {
          current_index=index;
        });
      },
      scrollDirection: Axis.horizontal,
      children: [
        LoanScreen(),
        CreditScreen()
      ],
    ),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: current_index,
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(

                icon: Icon(Icons.money_off_outlined),
                label: "Loan"
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.money_outlined),
                label: "Credit"
            ),
          ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 2,
        onPressed: () {
          if(current_index==0){
            showCreditProfile(context, TextEditingController(), current_index, 0);
          }

        },
        child: Icon(Icons.add, color: Colors.black,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
