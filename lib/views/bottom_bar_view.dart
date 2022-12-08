import 'package:flutter/material.dart';
import 'package:urnavotos/views/login_view.dart';
import 'package:urnavotos/views/poll_view.dart';
import 'package:urnavotos/views/survey_view.dart';

import '../values/custom_colors.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({Key? key}) : super(key: key);

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int currentTab = 0;
  final List<Widget> screens =[
    const SurveyView(),
    const PollView(),
  ];

  Widget currentScreen = const SurveyView();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/create_poll');
        },
        backgroundColor: CustomColors().getPrimaryButton,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 11, 11, 11),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary,),
          child: Container(
            height: MediaQuery.of(context).size.height*0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      onPressed: (){
                        setState(() {
                          currentScreen = SurveyView();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.format_list_bulleted,
                            color: currentTab == 0 ? CustomColors().getPrimaryButton : Colors.white ,
                          ),
                          Text("Enquetes", style: TextStyle(fontFamily: "Inter",color: currentTab == 0 ? CustomColors().getPrimaryButton : Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                    MaterialButton(
                      onPressed: (){
                        setState(() {
                          currentScreen = PollView();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.how_to_vote_outlined,
                            color: currentTab == 1 ? CustomColors().getPrimaryButton : Colors.white,
                          ),
                          Text("A Votar", style: TextStyle(fontFamily: "Inter",color: currentTab == 1 ? CustomColors().getPrimaryButton : Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
