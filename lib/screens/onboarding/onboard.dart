import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:lockbox/screens/Authentication/signin.dart';
import 'package:lockbox/screens/onboarding/page1.dart';
import 'package:lockbox/screens/onboarding/page2.dart';
import 'package:lockbox/screens/onboarding/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {

  bool islast=false;
  int curindex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Page1(),
          Page2(),
          Page3(),
        ],
        onPageChanged: (index){
          if(index==2){
            setState(() {
              islast=true;
            });
          }
          else if(islast=true){
            setState(() {
              islast=false;
            });
          }
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 100,
        child: Column(
          children: [
            Container(
              height: 35,
              color: Colors.purple[50],
              width: 100000,
              alignment: Alignment.topCenter,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  expansionFactor: 2,
                  activeDotColor: Colors.purple[700]??Colors.purple,
                  dotColor: Colors.purple[100]??Colors.grey,
                ),
                onDotClicked: (index){
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn
                  );
                  if(index==2){
                    setState(() {
                      islast=true;
                    });
                  }
                  else if(islast=true){
                    setState(() {
                      islast=false;
                    });
                  }
                },
              ),
            ),
            Container(
              color: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 7, 30, 0),
              child: islast?
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    overlayColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () async{
                    Navigator.pushReplacement(
                        context,
                      MaterialPageRoute(builder: (context) =>  SignIn()),
                    );
                  },
                  child: Container(
                    width: 165,
                    padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                    child: Row(
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.purple[600]
                          ),
                        ),
                        Container(
                            child: Icon(
                                Icons.arrow_forward,
                              color: Colors.purple[600],
                            ),
                          padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Colors.purple,
                            width: 2
                        )
                    ),
                  ),
                ),
              )
                  :Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      overlayColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: (){
                      _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple[700],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: Colors.purple,
                              width: 2
                          )
                      ),
                    ),
                  ),

                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      overlayColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: (){
                      _pageController.animateToPage(_pageController.page!.toInt()+ 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple[700],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: Colors.purple,
                              width: 2
                          )
                      ),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            ),
          ],
        ),
      ),
    );
  }
}

